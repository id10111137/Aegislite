//
//  A_RemoteTableViewCell.swift
//  Aegislite
//
//  Created by Tatang Roswandi Ganda Wijaya on 07/11/18.
//  Copyright © 2018 Tatang Roswandi Ganda Wijaya. All rights reserved.
//

import UIKit

class A_RemoteTableViewCell: UITableViewCell {

    @IBOutlet weak var lamp_name: UILabel!
    @IBOutlet weak var lamp_category: UILabel!
    @IBOutlet weak var lamp_status: UILabel!
    @IBOutlet weak var lamp_image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
