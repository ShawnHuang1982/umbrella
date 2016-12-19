//
//  CustomFavortieHeaderTableViewCell.swift
//  umbrella
//
//  Created by  shawn on 19/12/2016.
//  Copyright © 2016 shawn. All rights reserved.
//

import UIKit

class CustomFavortieHeaderTableViewCell: UITableViewCell {

    @IBAction func buttonEditFavoriteStation(_ sender: UIButton) {
    }
    
    @IBOutlet weak var viewInCell: UIView!
    @IBOutlet weak var labelFavoriteStation: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
