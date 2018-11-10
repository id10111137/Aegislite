//
//  C_Streaming_Detail.swift
//  Aegislite
//
//  Created by Tatang Roswandi Ganda Wijaya on 07/11/18.
//  Copyright © 2018 Tatang Roswandi Ganda Wijaya. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import SwiftyJSON
import CocoaMQTT

class C_Streaming_Detail: UIViewController, CocoaMQTTDelegate {

    @IBOutlet weak var ImageView: UIImageView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var categorySwitchIsOn:Bool =  false
    var mqtt: CocoaMQTT!
    var topics: String = ""
    
    @IBOutlet weak var txtLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = ""
          ImageView.sd_setImage(with: URL(string: (appDelegate.lamp_image)), placeholderImage: UIImage(named: "lp.png"))
        txtLabel.text = appDelegate.lamp_status
    }
    
    @IBAction func mySwitch(_ sender: AnyObject) {
        let bools  = sender.isOn as Bool
        if(bools == true){
            setUpMQTT(categorys: appDelegate.lamp_category,  messages: "ON")
            txtLabel.text = "ON"
            ImageView.image = UIImage(named: "lp")
        }else{
            setUpMQTT(categorys: appDelegate.lamp_category,  messages: "OFF")
             txtLabel.text = "OFF"
            ImageView.image = UIImage(named: "lpof")
        }
    }
    
//    PW : sugihart
//    LAMP : stat/sonoff-lamp/POWER
//    sWITCH : stat/sonoff-socket/POWER
//    CAMERA CONTROL :
//    UP & DOWN : myhome/dafang/motors/vertical/set => MESSAGE : up / down
//    LEFT & RIGHT : myhome/dafang/motors/horizontal/set => MESSAGE : left / right
    

    func setUpMQTT(categorys: String,  messages: String) {
        
        if(categorys == "Lampu"){
             topics = "cmnd/sonoff-lamp/POWER"
        }else if(categorys == "Switch"){
             topics = "cmnd/sonoff-socket/POWER"
        }
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
