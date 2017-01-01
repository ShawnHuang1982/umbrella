//
//  CustomFavoriteFooterTableViewCell.swift
//  umbrella
//
//  Created by  shawn on 19/12/2016.
//  Copyright © 2016 shawn. All rights reserved.
//

import UIKit

class CustomFavoriteFooterTableViewCell: UITableViewCell {

    @IBOutlet weak var btnFavoriteStatus: UIButton!
    @IBAction func buttonFavoritePress(_ sender: Any) {
    }
    var isFirstDisplay = false
//    @IBOutlet weak var labelUNBCanMoveNumber: UILabel!
    @IBOutlet weak var labelUNBNumberLeft: UILabel!
    @IBOutlet weak var bottomViewline: UIView!
    @IBOutlet weak var labelFavoriteContentStationName: UILabel!
    @IBOutlet weak var rightViewline: UIView!
    @IBOutlet weak var leftViewline: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    override func layoutSubviews() {
//        print("開始layoutSubViews")
//      //  print("c--->",isFirstDisplay)
//        //if !isFirstDisplay{
//    //    print("d--->",isFirstDisplay)
//        let path = UIBezierPath(roundedRect:bottomViewline.bounds, byRoundingCorners:[.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 30, height: 30))
//        let maskLayer = CAShapeLayer()
//        maskLayer.frame = bottomViewline.bounds
//        maskLayer.path = path.cgPath
//        bottomViewline.layer.mask = maskLayer
//         isFirstDisplay = true
//      // }
//    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
