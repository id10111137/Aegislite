//
//  C_Contact_Action.swift
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

class C_Contact_Action: UIViewController {
    
    @IBOutlet weak var Full_Name: UITextField!
    @IBOutlet weak var Ocouption: UITextField!
    @IBOutlet weak var Phone: UITextField!
    @IBOutlet weak var Address: UITextField!
    @IBOutlet weak var floaty: Floaty!
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.navigationBar.topItem?.title = ""
        if(appDelegate.id_streaming >= 1){
         Full_Name.text = appDelegate.name
            Ocouption.text = appDelegate.occupation
            Phone.text = appDelegate.phone
            Address.text = appDelegate.address
        }
        
        floaty.addItem("Kamera", icon: UIImage(named: "ma.png")!, handler: { item in
        })
        
        floaty.addItem("Gallery", icon: UIImage(named: "ma.png")!, handler: { item in
        })
        
        floaty.addItem("Log", icon: UIImage(named: "ma.png")!, handler: { item in
        })
        
        self.view.addSubview(floaty)
        
    }
    
    @IBAction func Add(_ sender: UIButton) {
        
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
