//
//  CustomFavoriteFooterTableViewCell.swift
//  umbrella
//
//  Created by  shawn on 19/12/2016.
//  Copyright © 2016 shawn. All rights reserved.
//

import UIKit

class CustomFavoriteFooterTableViewCell: UITableViewCell {


    @IBOutlet weak var labelUNBCanMoveNumber: UILabel!
    @IBOutlet weak var labelUNBNumberLeft: UILabel!
    @IBOutlet weak var bottomViewline: UIView!
    @IBOutlet weak var labelFavoriteContentStationName: UILabel!
    @IBOutlet weak var rightViewline: UIView!
    @IBOutlet weak var leftViewline: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
