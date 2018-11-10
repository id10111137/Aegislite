//
//  C_Streaming_Manual.swift
//  Aegislite
//
//  Created by Tatang Roswandi Ganda Wijaya on 07/11/18.
//  Copyright © 2018 Tatang Roswandi Ganda Wijaya. All rights reserved.
//

import UIKit
import CocoaMQTT
import Alamofire
import SwiftyJSON
import Floaty
import SDWebImage
import PopupDialog
import iOSDropDown

class C_Streaming_Manual: UIViewController {

    
    @IBOutlet weak var name_divace: UITextField!
    
    @IBOutlet weak var topic_divace: UITextField!
    
    @IBOutlet weak var TypeDivace: DropDown!
    @IBOutlet weak var floaty: Floaty!
    
       let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topic_divace.text = appDelegate.name
        
        floaty.addItem("Add Barcode", icon: UIImage(named: "br.png")!, handler: { item in
            self.performSegue(withIdentifier: "id_seg_addbarcode", sender: self)
        })
        
        self.view.addSubview(floaty)
        self.navigationController?.navigationBar.topItem?.title = ""
    
        TypeDivace.optionArray = ["Option 1", "Option 2", "Option 3"]
        TypeDivace.optionIds = [1,23,54,22]
        TypeDivace.didSelect{(selectedText , index ,id) in
            self.view.makeToast("Selected String: \(selectedText) \n index: \(index)")
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
