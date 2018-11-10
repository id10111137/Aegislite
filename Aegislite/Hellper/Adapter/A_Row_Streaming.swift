//
//  A_Row_Streaming.swift
//  Aegislite
//
//  Created by Tatang Roswandi Ganda Wijaya on 07/11/18.
//  Copyright © 2018 Tatang Roswandi Ganda Wijaya. All rights reserved.
//

import UIKit

class A_Row_Streaming: UITableViewCell {

    @IBOutlet weak var image_streaming: UIImageView!
    @IBOutlet weak var name_streaming: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var type: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.frame = frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
