//
//  A_Sequrty_Row.swift
//  Aegislite
//
//  Created by Tatang Roswandi Ganda Wijaya on 07/11/18.
//  Copyright © 2018 Tatang Roswandi Ganda Wijaya. All rights reserved.
//

import UIKit
import Floaty

class A_Sequrty_Row: UITableViewCell {

    @IBOutlet weak var image_sequrty: UIImageView!
    @IBOutlet weak var name_sequrty: UILabel!
    @IBOutlet weak var phone_sequrty: UILabel!
    @IBOutlet weak var ocouption_sequrty: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
      
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
