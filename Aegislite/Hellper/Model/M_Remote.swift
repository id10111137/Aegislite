//
//  M_Remote.swift
//  Aegislite
//
//  Created by Tatang Roswandi Ganda Wijaya on 07/11/18.
//  Copyright © 2018 Tatang Roswandi Ganda Wijaya. All rights reserved.
//

import Foundation
import UIKit

class M_Remote {
    
    var id_remote: Int = 0
    var lamp_image: String = ""
    var lamp_name: String = ""
    var lamp_category: String = ""
    var lamp_status: String = ""

    init ( id_remote: Int, lamp_image: String, lamp_name: String,
           lamp_category: String,
           lamp_status: String){
        self.id_remote = id_remote
        self.lamp_image = lamp_image
        self.lamp_name = lamp_name
        self.lamp_category = lamp_category
        self.lamp_status = lamp_status
        
    }
    
}
