//
//  C_Contact_Detail.swift
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


class C_Contact_Detail: UIViewController {

    
    @IBOutlet weak var Image_Contact: UIImageView!
    @IBOutlet weak var Full_Name: UILabel!
    @IBOutlet weak var Ocouption: UILabel!
    @IBOutlet weak var Phone: UILabel!
    @IBOutlet weak var Address: UILabel!
    @IBOutlet weak var floaty: Floaty!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
 self.navigationController?.navigationBar.topItem?.title = ""
        Full_Name.text = appDelegate.name
        Ocouption.text = appDelegate.occupation
        Phone.text = appDelegate.phone
        Address.text = appDelegate.address
        
        floaty.addItem("Update Profil", icon: UIImage(named: "br.png")!, handler: { item in
            
            self.appDelegate.id_streaming = self.appDelegate.id_streaming
            self.appDelegate.name = self.appDelegate.name
            self.appDelegate.occupation = self.appDelegate.occupation
            self.appDelegate.address = self.appDelegate.address
            self.appDelegate.phone = self.appDelegate.phone
            self.appDelegate.created_at = self.appDelegate.created_at
            self.appDelegate.updated_at = self.appDelegate.updated_at
            self.appDelegate.image = self.appDelegate.image
            
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
