//
//  A_UserTableViewCell.swift
//  Aegislite
//
//  Created by Tatang Roswandi Ganda Wijaya on 06/11/18.
//  Copyright © 2018 Tatang Roswandi Ganda Wijaya. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class A_UserTableViewCell: UITableViewCell {

    @IBOutlet weak var user_name: UILabel!
    @IBOutlet weak var user_phone: UILabel!
    @IBOutlet weak var image_user: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
