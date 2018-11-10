//
//  A_Contact_Cell.swift
//  Aegislite
//
//  Created by Tatang Roswandi Ganda Wijaya on 08/11/18.
//  Copyright © 2018 Tatang Roswandi Ganda Wijaya. All rights reserved.
//

import UIKit

class A_Contact_Cell: UITableViewCell {

    
    @IBOutlet weak var Image_Contact: UIImageView!
    @IBOutlet weak var Name_Contact: UILabel!
    @IBOutlet weak var Phone_Contact: UILabel!
    @IBOutlet weak var Ocouption_Contact: UILabel!
    @IBOutlet weak var Address_Contact: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
