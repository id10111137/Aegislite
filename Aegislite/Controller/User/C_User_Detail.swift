//
//  C_User_Detail.swift
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

class C_User_Detail: UIViewController {

    @IBOutlet weak var image_user: UIImageView!
    @IBOutlet weak var name_user: UILabel!
    @IBOutlet weak var email_user: UILabel!
    @IBOutlet weak var password_user: UILabel!
    @IBOutlet weak var address_user: UILabel!
    @IBOutlet weak var phone_user: UILabel!
    @IBOutlet weak var floaty: Floaty!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 self.navigationController?.navigationBar.topItem?.title = ""
        name_user.text = appDelegate.name
        email_user.text = appDelegate.email
        password_user.text = "*******"
        address_user.text = appDelegate.address
        phone_user.text = appDelegate.phone
        
        floaty.addItem("Update User", icon: UIImage(named: "br.png")!, handler: { item in
            
            self.appDelegate.id_streaming = self.appDelegate.id_streaming
            self.appDelegate.name = self.appDelegate.name
            self.appDelegate.username = self.appDelegate.username
            self.appDelegate.email = self.appDelegate.email
            self.appDelegate.created_at = self.appDelegate.created_at
            self.appDelegate.updated_at = self.appDelegate.updated_at
            self.appDelegate.regid = self.appDelegate.regid
            self.appDelegate.image = self.appDelegate.image
            self.appDelegate.phone = self.appDelegate.phone
            self.appDelegate.address = self.appDelegate.address
            self.appDelegate.isadmins = self.appDelegate.isadmins
        
            self.performSegue(withIdentifier: "id_seg_update", sender: self)
        })
        self.view.addSubview(floaty)
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
