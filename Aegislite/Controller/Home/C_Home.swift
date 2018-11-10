//
//  C_Home.swift
//  Aegislite
//
//  Created by Tatang Roswandi Ganda Wijaya on 05/11/18.
//  Copyright © 2018 Tatang Roswandi Ganda Wijaya. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import Floaty
import SDWebImage
import Toast_Swift



class C_Home: UIViewController {
    
    @IBOutlet weak var txt_home: UILabel!
    @IBOutlet weak var txt_email: UILabel!
    @IBOutlet weak var txt_status: UILabel!
    


    @IBOutlet weak var profil_apps: UIImageView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaultValues = UserDefaults.standard
        if let token = defaultValues.string(forKey: "token"){
            appDelegate.token = token
        }else{
            //send back to login view controller
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "login_page") as! MainTabViewController
            self.present(vc, animated: true, completion: nil)
        }
        

        let bg = UIImage.init(named: "bg.png")
        let bgView = UIImageView.init(frame: self.view.frame)
        bgView.image = bg
        bgView.contentMode = .scaleAspectFill
        bgView.alpha = 0.5
        self.view.insertSubview(bgView, at: 0)
        profil_apps.roundedImage()
        loadUser()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        let nv = navigationController!
        let image = UIImage(named: "Logo")
        let ImageView = UIImageView(image: image)
        let bnw = nv.navigationBar.frame.size.width
        let bnh = nv.navigationBar.frame.size.height
        
        ImageView.frame = CGRect(x:0, y:0, width: bnw, height: bnh)
        
        ImageView.contentMode = .scaleAspectFit
        ImageView.center = nv.navigationBar.center
        navigationItem.titleView = ImageView
        
    }
    
    func loadUser(){
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer "+appDelegate.token,
            "Accept": "application/json"
        ]
        
        Alamofire.request("http://devcctv.sugihartdigital.id/api/getuser", method: .post, headers: headers).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                self.txt_home.text = json["data"]["name"].string as Any as? String
                self.txt_email.text = json["data"]["email"].string as Any as? String
                self.txt_status.text = "Active"
                
                self.appDelegate.idx = json["data"]["id"].int as Any as! Int
                self.appDelegate.name = (json["data"]["name"].string as Any as? String)!
                self.appDelegate.username = (json["data"]["username"].string as Any as? String)!
                self.appDelegate.email = (json["data"]["email"].string as Any as? String)!
                self.appDelegate.created_at = (json["data"]["created_at"].string as Any as? String)!
                self.appDelegate.updated_at = (json["data"]["updated_at"].string as Any as? String)!
                self.appDelegate.regid = (json["data"]["regid"].string as Any as? String)!
                self.appDelegate.image = (json["data"]["image"].string as Any as? String)!
                self.appDelegate.phone = (json["data"]["phone"].string as Any as? String)!
                self.appDelegate.address = (json["data"]["address"].string as Any as? String)!
                self.appDelegate.isadmins = json["data"]["is_admin"].int as Any as! Int
                
                
                self.profil_apps.sd_setImage(with: URL(string: ("http://devcctv.sugihartdigital.id/storage/user/"+json["data"]["image"].string! as Any as? String)!), placeholderImage: UIImage(named: "sc.png"))
            case .failure(let error):
                print(error)
                self.view.makeToast("Disconected Internet")
            }
            
        }
    }
 
    
    @IBAction func btn_sequrty(_ sender: UIButton) {
        self.performSegue(withIdentifier: "id_seg_sequrty", sender: self)
    }
    
    @IBAction func btn_user(_ sender: Any) {
        self.performSegue(withIdentifier: "id_seg_user", sender: self)
    }
    
    @IBAction func btn_log(_ sender: UIButton) {
        self.performSegue(withIdentifier: "id_seg_log", sender: self)
    }
    
   
    
    @IBAction func lgout(_ sender: Any) {
        //removing values from default
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
        
        //switching to login screen
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "login_page") as! ViewController
        self.navigationController?.pushViewController(loginViewController, animated: true)
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func btn_pannic(_ sender: Any) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "id_pannic") as! C_Pannic
//        self.present(vc, animated: true, completion: nil)
        self.performSegue(withIdentifier: "id_seg_panic", sender: self)
    }
    @IBAction func btn_contact(_ sender: Any) {
        self.performSegue(withIdentifier: "id_seg_contact", sender: self)
    }
    
    

    
 
}

