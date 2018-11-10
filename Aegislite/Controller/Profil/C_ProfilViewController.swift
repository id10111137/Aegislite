//
//  C_ProfilViewController.swift
//  Aegislite
//
//  Created by Tatang Roswandi Ganda Wijaya on 05/11/18.
//  Copyright © 2018 Tatang Roswandi Ganda Wijaya. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Floaty
import SDWebImage
import PopupDialog

class C_ProfilViewController: UIViewController {

    
    @IBOutlet weak var ImageProfil: UIImageView!
    @IBOutlet weak var name_profil: UILabel!
    @IBOutlet weak var full_name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var address: UILabel!
    
    
    @IBOutlet weak var floaty: Floaty!
     let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
 self.navigationController?.navigationBar.topItem?.title = ""
        let bg = UIImage.init(named: "bg.png")
        let bgView = UIImageView.init(frame: self.view.frame)
        bgView.image = bg
        bgView.contentMode = .scaleAspectFill
        bgView.alpha = 0.5
        self.view.insertSubview(bgView, at: 0)
        
        
        floaty.addItem("Edit Profil", icon: UIImage(named: "edit.png")!, handler: { item in
            self.performSegue(withIdentifier: "id_seg_profil", sender: self)
        })
        self.view.addSubview(floaty)
        
        
        name_profil.text = appDelegate.name
        full_name.text = appDelegate.name
        email.text = appDelegate.email
        username.text = appDelegate.username
        phone.text = appDelegate.phone
        address.text =  appDelegate.address
        
    
        
        ImageProfil.sd_setImage(with: URL(string: "http://devcctv.sugihartdigital.id/storage/user/"+appDelegate.image), placeholderImage: UIImage(named: "placeholder.png"))
        ImageProfil.roundedImage()

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
