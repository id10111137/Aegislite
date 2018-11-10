//
//  C_Sequrty_Detail.swift
//  Aegislite
//
//  Created by Tatang Roswandi Ganda Wijaya on 08/11/18.
//  Copyright © 2018 Tatang Roswandi Ganda Wijaya. All rights reserved.
//

import UIKit
import Floaty
import Alamofire

class C_Sequrty_Detail: UIViewController {

    @IBOutlet weak var floaty: Floaty!
    @IBOutlet weak var image_sequrty: UIImageView!
    @IBOutlet weak var name_sequrty: UILabel!
    @IBOutlet weak var ocouption_sequrty: UILabel!
    @IBOutlet weak var phone_sequrty: UILabel!
    
    var id_sequrty: Int = 0

    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.navigationBar.topItem?.title = ""
        name_sequrty.text = appDelegate.name_streaming
        ocouption_sequrty.text = appDelegate.occupation
        phone_sequrty.text = appDelegate.phone
        id_sequrty = appDelegate.id_streaming
        
        
        
        floaty.addItem("Update Profil", icon: UIImage(named: "br.png")!, handler: { item in
            
            
        self.appDelegate.id_streaming = self.id_sequrty
        self.appDelegate.name_streaming = self.name_sequrty.text!
        self.appDelegate.phone = self.phone_sequrty.text!
        self.appDelegate.occupation = self.ocouption_sequrty.text!
            
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
