//
//  C_Sequrty_Action.swift
//  Aegislite
//
//  Created by Tatang Roswandi Ganda Wijaya on 08/11/18.
//  Copyright © 2018 Tatang Roswandi Ganda Wijaya. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import SDWebImage

class C_Sequrty_Action: UIViewController {

    
    @IBOutlet weak var Image_Sequrty: UIImageView!
    @IBOutlet weak var Name_Sequrty: UITextField!
    @IBOutlet weak var Ocouption_Sequrty: UITextField!
    @IBOutlet weak var Phone_Sequrty: UITextField!
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     self.navigationController?.navigationBar.topItem?.title = ""
        if(appDelegate.id_streaming >= 1){
            Name_Sequrty.text = appDelegate.name_streaming
            Ocouption_Sequrty.text = appDelegate.occupation
            Phone_Sequrty.text = appDelegate.phone
            
        }
       
    }
//    api/security/create => (name,occupation,phone,active(default : 0 ) )

    @IBAction func Add_Sequrty(_ sender: Any) {
        if(appDelegate.id_streaming >= 1){
            updateData()
        }else{
            loadAdd()
        }
    }
    
    func loadAdd(){
        let parameters: Parameters=[
            "name":Name_Sequrty.text!,
            "occupation":Ocouption_Sequrty.text!,
            "phone":Phone_Sequrty.text!,
            "active":0
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer "+appDelegate.token,
            "Accept": "application/json"
        ]
        
        //making a post request
        Alamofire.request("http://devcctv.sugihartdigital.id/api/security/create", method: .post, parameters: parameters, headers: headers).responseJSON
            {
                response in
                
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                    if(!((jsonData.value(forKey: "success") != nil))){
                        self.view.makeToast("Gagal Input")
                    }else{
                        //                        let user = jsonData.value(forKey: "success") as Any
                        self.view.makeToast("Input Berhasil")
                        self.Name_Sequrty.text = ""
                        self.Ocouption_Sequrty.text = ""
                        self.Phone_Sequrty.text = ""
                    }
                }
                
        }
    }
    
//    api/security/update  => (id,name,occupation,phone,active(default : 0 ) )
    
    
    func updateData(){
        let parameters: Parameters=[
            "id":appDelegate.id_streaming,
            "name":Name_Sequrty.text!,
            "occupation":Ocouption_Sequrty.text!,
            "phone":Phone_Sequrty.text!,
            "active":0
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer "+appDelegate.token,
            "Accept": "application/json"
        ]
        
        //making a post request
        Alamofire.request("http://devcctv.sugihartdigital.id/api/security/update", method: .post, parameters: parameters, headers: headers).responseJSON
            {
                response in
                
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                    if(!((jsonData.value(forKey: "success") != nil))){
                        self.view.makeToast("Gagal Update")
                    }else{
                        //                        let user = jsonData.value(forKey: "success") as Any
                        self.view.makeToast("Update Berhasil")
                    }
                }
                
        }
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
