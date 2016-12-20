//
//  CustomStaionListTableViewCell.swift
//  umbrella
//
//  Created by  shawn on 20/12/2016.
//  Copyright © 2016 shawn. All rights reserved.
//

import UIKit

class CustomStaionListTableViewCell: UITableViewCell {
    @IBOutlet weak var labelRouteName: UILabel!

    @IBOutlet weak var labelRouteExitName: UILabel!
    @IBOutlet weak var imageViewRouteColor: UIImageView!
    
    @IBOutlet weak var labelLocationNearDistance: UILabel!
    @IBOutlet weak var btnMyFavoriteStation: UIButton!
    @IBAction func buttonMyFavoriteStation(_ sender: UIButton) {
    }
    @IBOutlet weak var imageViewIsFavorite: UIImageView!
    @IBOutlet weak var labelNUBleftNumber: UILabel!
    @IBOutlet weak var labelNUBCanMove: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
