//
//  C_Profil_Detail.swift
//  Aegislite
//
//  Created by Tatang Roswandi Ganda Wijaya on 06/11/18.
//  Copyright © 2018 Tatang Roswandi Ganda Wijaya. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class C_Profil_Detail: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var profil: UIImageView!
    @IBOutlet weak var full_name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var address: UITextField!
    
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var picker:UIImagePickerController?=UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(appDelegate.idx)
         self.navigationController?.navigationBar.topItem?.title = ""
        full_name.text = appDelegate.name
        email.text = appDelegate.email
        username.text = appDelegate.username
        phone.text = appDelegate.phone
        address.text = appDelegate.address
        
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector(("tapGesture")))
        profil.addGestureRecognizer(tapGesture)
        profil.isUserInteractionEnabled = true
        picker!.delegate = self
        
        
    }
    
    @IBAction func btn_update(_ sender: Any) {
        
        
    }
    
    
    /*
     set Image Take And Gallery Phone
     */
    func tapGesture(gesture: UIGestureRecognizer) {
        
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        let gallaryAction = UIAlertAction(title: "Open Gallary", style: UIAlertAction.Style.default)
        {
            UIAlertAction in self.openGallary()
        }
        
        let takePhoto = UIAlertAction(title: "Take Photo", style: UIAlertAction.Style.default)
        {
            UIAlertAction in self.takePhoto()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        {
            UIAlertAction in self.cancel()
        }
        alert.addAction(gallaryAction)
        alert.addAction(takePhoto)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func openGallary()
    {
        picker!.allowsEditing = false
        picker!.sourceType = UIImagePickerController.SourceType.photoLibrary
        present(picker!, animated: true, completion: nil)
    }
    
    func takePhoto(){
        picker!.delegate = self
        picker!.allowsEditing = false
        picker!.sourceType = UIImagePickerController.SourceType.camera
        present(picker!, animated: true, completion: nil)
    }
    
    
    func cancel(){
        print("Cancel Clicked")
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage

        profil.contentMode = .scaleAspectFill
        profil.image = chosenImage
        dismiss(animated: true, completion: nil)
    }
    
    
    /*
     End Image Take And Gallery Phone
     */
    
    
   
    
}
