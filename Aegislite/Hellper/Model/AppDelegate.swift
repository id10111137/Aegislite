//
//  AppDelegate.swift
//  Aegislite
//
//  Created by Tatang Roswandi Ganda Wijaya on 05/11/18.
//  Copyright © 2018 Tatang Roswandi Ganda Wijaya. All rights reserved.
//

import UIKit
import PopupDialog

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var token : String = ""

    var window: UIWindow?
    
    /*
        profil
     */
    var idx : Int = 0
    var name : String = ""
    var username : String = ""
    var email : String = ""
    var created_at : String = ""
    var updated_at : String = ""
    var regid : String = ""
    var image : String = ""
    var phone : String = ""
    var address : String = ""
    var isadmins : Int = 0
    
    /*
        remote
    */
    var id_remote: Int = 0
    var lamp_image: String = ""
    var lamp_name: String = ""
    var lamp_category: String = ""
    var lamp_status: String = ""
    
    /*
        Streaming
    */
    
    var id_streaming: Int = 0
    var image_streaming: String = ""
    var name_streaming: String = ""
    var category: String = ""
    var type: String = ""
    var occupation: String = ""
    
 

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
//    // Customize dialog appearance
//    let pv = PopupDialogDefaultView.appearance()
//    pv.titleFont    = UIFont(name: "HelveticaNeue-Light", size: 16)!
//    pv.titleColor   = .white
//    pv.messageFont  = UIFont(name: "HelveticaNeue", size: 14)!
//    pv.messageColor = UIColor(white: 0.8, alpha: 1)
//    
//    // Customize the container view appearance
//    let pcv = PopupDialogContainerView.appearance()
//    pcv.backgroundColor = UIColor(red:0.23, green:0.23, blue:0.27, alpha:1.00)
//    pcv.cornerRadius    = 2
//    pcv.shadowEnabled   = true
//    pcv.shadowColor     = .black
//    
//    // Customize overlay appearance
//    let ov = PopupDialogOverlayView.appearance()
//    ov.blurEnabled     = true
//    ov.blurRadius      = 30
//    ov.liveBlurEnabled = true
//    ov.opacity         = 0.7
//    ov.color           = .black
//    
//    // Customize default button appearance
//    let db = DefaultButton.appearance()
//    db.titleFont      = UIFont(name: "HelveticaNeue-Medium", size: 14)!
//    db.titleColor     = .white
//    db.buttonColor    = UIColor(red:0.25, green:0.25, blue:0.29, alpha:1.00)
//    db.separatorColor = UIColor(red:0.20, green:0.20, blue:0.25, alpha:1.00)
//    
//    // Customize cancel button appearance
//    let cb = CancelButton.appearance()
//    cb.titleFont      = UIFont(name: "HelveticaNeue-Medium", size: 14)!
//    cb.titleColor     = UIColor(white: 0.6, alpha: 1)
//    cb.buttonColor    = UIColor(red:0.25, green:0.25, blue:0.29, alpha:1.00)
//    cb.separatorColor = UIColor(red:0.20, green:0.20, blue:0.25, alpha:1.00)


}

extension UIImageView {
    
    func roundedImage() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }
    
}
