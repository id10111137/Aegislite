//
//  M_Sequrty.swift
//  Aegislite
//
//  Created by Tatang Roswandi Ganda Wijaya on 07/11/18.
//  Copyright © 2018 Tatang Roswandi Ganda Wijaya. All rights reserved.
//

import Foundation
class M_Sequrty {
    
    var id_sequrty: Int = 0
    var image_sequrty: String = ""
    var occupation: String = ""
    var active: String = ""
    var name_sequrty: String = ""
    var phone_sequrty: String = ""
    var created_at: String = ""
    var updated_at: String = ""
    
    
    init (id_sequrty: Int , image_sequrty: String, occupation: String, active: String, name_sequrty: String, phone_sequrty: String, created_at: String, updated_at: String){
        self.id_sequrty =  id_sequrty
        self.image_sequrty=image_sequrty
        self.occupation=occupation
        self.active=active
        self.name_sequrty=name_sequrty
        self.phone_sequrty=phone_sequrty
        self.created_at=created_at
        self.updated_at=updated_at
    }
}

