//
//  FavoriteCellHeader.swift
//  umbrella
//
//  Created by  shawn on 30/12/2016.
//  Copyright © 2016 shawn. All rights reserved.
//

import UIKit

class FavoriteCellHeader: UIView {

    override func layoutSubviews() {
                let path = UIBezierPath(roundedRect:self.bounds, byRoundingCorners:[.topLeft, .topRight], cornerRadii: CGSize(width: 10, height: 10))
                let maskLayer = CAShapeLayer()
                maskLayer.frame = self.bounds
                maskLayer.path = path.cgPath
                self.layer.mask = maskLayer
        
//        self.layer.masksToBounds = false
//        self.layer.shadowOffset = CGSize.zero
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowRadius = 4
//        self.layer.shadowOpacity = 0.23
//        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
//        self.layer.shouldRasterize = true
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
