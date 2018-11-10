//
//  ViewController.swift
//  Aegislite
//
//  Created by Tatang Roswandi Ganda Wijaya on 05/11/18.
//  Copyright © 2018 Tatang Roswandi Ganda Wijaya. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Floaty

class ViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var is_securitys : String!
    
    let defaultValues = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let bg = UIImage.init(named: "bg.png")
        let bgView = UIImageView.init(frame: self.view.frame)
        bgView.image = bg
        bgView.contentMode = .scaleAspectFill
        bgView.alpha = 0.5
        self.view.insertSubview(bgView, at: 0)
        
        
        if defaultValues.string(forKey: "token") != nil{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "id_main_tab") as! MainTabViewController
            self.present(vc, animated: true, completion: nil)
            
        }
        
        
       
    }
    
    @IBAction func btn_forgot(_ sender: Any) {
        self.performSegue(withIdentifier: "id_seg_forgot", sender: self)
    }
    
    @IBAction func btn_login(_ sender: Any) {

        let parameters: Parameters=[
            "email":username.text!,
            "password":password.text!
        ]

        //making a post request
        Alamofire.request("http://devcctv.sugihartdigital.id/api/login", method: .post, parameters: parameters).responseJSON
            {
                response in
                                
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                    if(!((jsonData.value(forKey: "success") != nil))){
                        print("Gagal")
                    }else{
                        let user = jsonData.value(forKey: "success") as! NSDictionary
                        //getting user values
                        let token = user.value(forKey: "token") as! String
                        let email = user.value(forKey: "email") as! String
                        let regid = user.value(forKey: "regid") as! String
                        let is_admin = user.value(forKey: "is_admin") as! Int

                        //saving user values to defaults
                        self.defaultValues.set(token, forKey: "token")
                        self.defaultValues.set(email, forKey: "email")
                        self.defaultValues.set(regid, forKey: "regid")
                        self.defaultValues.set(is_admin, forKey: "is_admin")

                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "id_main_tab") as! MainTabViewController
                        self.present(vc, animated: true, completion: nil)
                        
                    }
                }
        }
    }
}

