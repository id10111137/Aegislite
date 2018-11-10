//
//  M_Streaming.swift
//  Aegislite
//
//  Created by Tatang Roswandi Ganda Wijaya on 07/11/18.
//  Copyright © 2018 Tatang Roswandi Ganda Wijaya. All rights reserved.
//

import Foundation

class M_Streaming {
    
    var id_streaming: Int = 0
    var image_streaming: String = ""
    var name_streaming: String = ""
    var category: String = ""
    var type: String = ""
    
    init ( id_streaming: Int, image_streaming: String, name_streaming: String,
           category: String,
           type: String){
        self.id_streaming = id_streaming
        self.image_streaming = image_streaming
        self.name_streaming = name_streaming
        self.category = category
        self.type = type
        
    }
}
