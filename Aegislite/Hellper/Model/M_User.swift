//
//  M_User.swift
//  Aegislite
//
//  Created by Tatang Roswandi Ganda Wijaya on 06/11/18.
//  Copyright © 2018 Tatang Roswandi Ganda Wijaya. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class M_User {
    
    var id: Int = 0
    var name: String = ""
    var username: String = ""
    var email: String = ""
    var created_at: String = ""
    var updated_at: String = ""
    var regid: String = ""
    var image: String = ""
    var phone: String = ""
    var address: String = ""
    var is_admin : Int = 0
    
    
    init ( id: Int,
           name: String,
           username: String,
           email: String,
           created_at: String,
           updated_at: String,
           regid: String,
           image: String,
           phone: String,
           address: String,
           is_admin : Int){
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.created_at = created_at
        self.updated_at = updated_at
        self.regid = regid
        self.image = image
        self.phone = phone
        self.address = address
        self.is_admin = is_admin
    }
}
