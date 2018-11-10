//
//  C_Pannic.swift
//  Aegislite
//
//  Created by Tatang Roswandi Ganda Wijaya on 05/11/18.
//  Copyright © 2018 Tatang Roswandi Ganda Wijaya. All rights reserved.
//

import UIKit

class C_Pannic: UIViewController {

    let messageComposer = MessageComposers()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = " "
        let bg = UIImage.init(named: "bg.png")
        let bgView = UIImageView.init(frame: self.view.frame)
        bgView.image = bg
        bgView.contentMode = .scaleAspectFill
        bgView.alpha = 0.5
        self.view.insertSubview(bgView, at: 0)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btn_Pannic(_ sender: Any) {
        if (messageComposer.canSendText()) {
            let messageComposeVC = messageComposer.configuredMessageComposeViewController()
            present(messageComposeVC, animated: true, completion: nil)
        } else {
            
            let alertController = UIAlertController(title: "Gagal Mengirim Pesan", message:
                "Divace Anda Tidak Support", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
            
        }
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
