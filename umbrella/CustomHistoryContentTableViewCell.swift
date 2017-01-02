//
//  CustomHistoryContentTableViewCell.swift
//  umbrella
//
//  Created by  shawn on 02/01/2017.
//  Copyright © 2017 shawn. All rights reserved.
//

import UIKit

class CustomHistoryContentTableViewCell: UITableViewCell {
    @IBOutlet weak var labelRentDate: UILabel!
    @IBOutlet weak var labelRentMoney: UILabel!
    @IBOutlet weak var labelRentDay: UILabel!
    @IBOutlet weak var labelStartToEndStation: UILabel!
    
    @IBOutlet weak var imageRouteColor2: UIImageView!
    @IBOutlet weak var imageRouteColor1: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
