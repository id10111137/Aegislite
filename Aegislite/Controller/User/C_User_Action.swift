//
//  C_User_Action.swift
//  Aegislite
//
//  Created by Tatang Roswandi Ganda Wijaya on 08/11/18.
//  Copyright © 2018 Tatang Roswandi Ganda Wijaya. All rights reserved.
//

import UIKit
import CocoaMQTT
import Alamofire
import SwiftyJSON
import Floaty
import SDWebImage
import PopupDialog

class C_User_Action: UIViewController {

    
    @IBOutlet weak var full_name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var phone: UITextField!
    
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
 self.navigationController?.navigationBar.topItem?.title = ""
        if(appDelegate.id_streaming >= 1){
            full_name.text = appDelegate.name
            email.text = appDelegate.email
            password.text = ""
            address.text = appDelegate.address
            phone.text = appDelegate.phone
        }
    }


    @IBAction func Actions(_ sender: Any) {
        if(appDelegate.id_streaming >= 1){
            updateData()
        }else{
            loadAdd()
        }
    }

    
    func loadAdd(){
        let parameters: Parameters=[
            "name":full_name.text!,
            "password":password.text!,
            "email":email.text!,
            "username":email.text!,
            "address":address.text!,
            "phone":phone.text!,
            "is_admin":0
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer "+appDelegate.token,
            "Accept": "application/json"
        ]
        
        //making a post request
        Alamofire.request("http://devcctv.sugihartdigital.id/api/createuser", method: .post, parameters: parameters, headers: headers).responseJSON
            {
                response in
                
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                    if(!((jsonData.value(forKey: "success") != nil))){
                        self.view.makeToast("Gagal Input")
                    }else{
                        //                        let user = jsonData.value(forKey: "success") as Any
                        self.view.makeToast("Add Berhasil")
                        self.full_name.text = ""
                        self.email.text = ""
                        self.password.text = ""
                        self.address.text = ""
                        self.phone.text = ""
                    }
                }
                
        }
    }
    
    
    func updateData(){
        let parameters: Parameters=[
            "id":appDelegate.id_streaming,
            "name":full_name.text!,
            "password":password.text!,
            "email":email.text!,
            "username":email.text!,
            "address":address.text!,
            "phone":phone.text!,
            "is_admin":0
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer "+appDelegate.token,
            "Accept": "application/json"
        ]
        
        //making a post request
        Alamofire.request("http://devcctv.sugihartdigital.id/api/updateuser", method: .post, parameters: parameters, headers: headers).responseJSON
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
