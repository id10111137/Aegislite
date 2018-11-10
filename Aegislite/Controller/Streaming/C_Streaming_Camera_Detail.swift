//
//  C_Streaming_Camera_Detail.swift
//  Aegislite
//
//  Created by Tatang Roswandi Ganda Wijaya on 07/11/18.
//  Copyright © 2018 Tatang Roswandi Ganda Wijaya. All rights reserved.
//

import UIKit
import CocoaMQTT
import Alamofire
import Toast_Swift
import AVFoundation
import AVKit




class C_Streaming_Camera_Detail: UIViewController, CocoaMQTTDelegate {

    
    @IBOutlet weak var cameraDetail: UIView!
    
    
//    @IBOutlet weak var txtLabel: UILabel!
    
    @IBOutlet weak var btn_recorder: UIButton!
    @IBOutlet weak var btn_resize: UIButton!
    @IBOutlet weak var btn_volume: UIButton!
    @IBOutlet weak var btn_audio: UIButton!
//    @IBOutlet weak var btn_nav_top: UIButton!
//    @IBOutlet weak var btn_nav_right: UIButton!
//    @IBOutlet weak var btn_nav_btn: UIButton!
//    @IBOutlet weak var btn_nav_left: UIButton!
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var mqtt: CocoaMQTT!
    var topics: String = ""
    let playerViewController = AVPlayerViewController()
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.navigationBar.topItem?.title = ""
        // Do any additional setup after loading the view.
        
        let videoURL = URL(string: "rtsp://192.168.1.2:8554/unicast")
        let player = AVPlayer(url: videoURL!)
        playerViewController.player = player
        
//        self.present(playerViewController, animated: true) {
            self.cameraDetail.addSubview(self.playerViewController.view)
            self.playerViewController.view.frame = self.cameraDetail.bounds
            self.playerViewController.player!.play()
//        }
        
        
     
        
    }
    
    //    PW : sugihart
    //    LAMP : stat/sonoff-lamp/POWER
    //    sWITCH : stat/sonoff-socket/POWER
    //    CAMERA CONTROL :
    //    UP & DOWN : myhome/dafang/motors/vertical/set => MESSAGE : up / down
    //    LEFT & RIGHT : myhome/dafang/motors/horizontal/set => MESSAGE : left / right
    
    @IBAction func btn_up(_ sender: UIButton) {
        setUpMQTT(categorys: "vertical",  messages: "up")
        self.view.makeToast("Atas")
    }
    
  
    @IBAction func btn_right(_ sender: UIButton) {
        setUpMQTT(categorys: "horizontal",  messages: "right")
        self.view.makeToast("Kanan")
    }
    
    
    @IBAction func btn_dwn(_ sender: UIButton) {
        setUpMQTT(categorys: "vertical",  messages: "dwon")
        self.view.makeToast("bawah")
    }
    
    @IBAction func btn_left(_ sender: UIButton) {
        setUpMQTT(categorys: "horizontal",  messages: "left")
        self.view.makeToast("kiri")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    func setUpMQTT(categorys: String,  messages: String) {
        
        if(categorys == "vertical"){
            topics = "myhome/dafang/motors/vertical/set"
        }else if(categorys == "horizontal"){
            topics = "myhome/dafang/motors/horizontal/set"
        }
        
        print(messages)
        
        let clientID = "CocoaMQTT-" + String(ProcessInfo().processIdentifier)
        mqtt = CocoaMQTT(clientID: clientID, host: "206.189.146.88", port: 1883)
        mqtt.username = "sugihart"
        mqtt.password = "sugihart"
        mqtt.willMessage = CocoaMQTTWill(topic: topics, message: messages)
        mqtt.keepAlive = 60
        mqtt.subscribe(topics)
        mqtt.connect()
        mqtt.didReceiveMessage = { mqtt, message, id in
            print("Message received in topic \(message.topic) with payload \(message.string!)")
        }
    }
    
    
    func mqtt(_ mqtt: CocoaMQTT, didReceive trust: SecTrust, completionHandler: @escaping (Bool) -> Void) {
        self.mqtt?.allowUntrustCACertificate = true
        
        completionHandler(true)
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didConnect host: String, port: Int) {
        print("didConnect \(host):\(port)")
        mqtt.subscribe("topic1")
        mqtt.ping()
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck){
        print("didConnectAck: \(ack)，rawValue: \(ack.rawValue)")
        
        if ack == .accept {
            mqtt.subscribe("topic1", qos: CocoaMQTTQOS.qos1)
        }
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
        print("didPublishMessage with message: \(message.string!)")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {
        print("didPublishAck with id: \(id)")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16 ) {
        print("didReceivedMessage: \(message.string!) with id \(id)")
        
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopic topic: String) {
        print("didSubscribeTopic to \(topic)")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopic topic: String) {
        print("didUnsubscribeTopic to \(topic)")
    }
    
    func mqttDidPing(_ mqtt: CocoaMQTT) {
        print("didPing")
    }
    
    func mqttDidReceivePong(_ mqtt: CocoaMQTT) {
        _console("didReceivePong")
    }
    
    func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: Error?) {
        _console("mqttDidDisconnect")
        print(err!)
        //        mqtt.autoReconnect = true
    }
    
    func _console(_ info: String) {
        print("Delegate: \(info)")
    }

}
