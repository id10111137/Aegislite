//
//  M_Contact.swift
//  Aegislite
//
//  Created by Tatang Roswandi Ganda Wijaya on 08/11/18.
//  Copyright © 2018 Tatang Roswandi Ganda Wijaya. All rights reserved.
//

import Foundation
class M_Contact {
    
    var id: Int = 0
    var name: String = ""
    var occupation: String = ""
    var address: String = ""
    var phone: String = ""
    var created_at: String = ""
    var updated_at: String = ""
    var photo: String = ""
    
    init(id: Int,name: String,occupation: String,address: String,phone: String, created_at: String,updated_at: String,photo: String){
        
        self.id = id
        self.name = name
        self.occupation = occupation
        self.address = address
        self.phone = phone
        self.created_at = created_at
        self.updated_at = updated_at
        self.photo = photo
        
    }
 
}

