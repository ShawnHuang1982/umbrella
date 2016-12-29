//
//  CustomFavoriteContentTableViewCell.swift
//  umbrella
//
//  Created by  shawn on 19/12/2016.
//  Copyright © 2016 shawn. All rights reserved.
//

import UIKit

class CustomFavoriteContentTableViewCell: UITableViewCell {

    
    @IBOutlet weak var bottomViewline: UIView!
    @IBOutlet weak var rightViewline: UIView!
    @IBOutlet weak var leftViewline: UIView!    
    @IBOutlet weak var labelUNBNumberLeft: UILabel!
    @IBOutlet weak var labelFavoriteContentStationName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
