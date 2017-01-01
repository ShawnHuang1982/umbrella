//
//  MapView.swift
//  umbrella
//
//  Created by  shawn on 01/01/2017.
//  Copyright © 2017 shawn. All rights reserved.
//

import UIKit

class MapView: UIView {
    override func layoutSubviews() {
        let path = UIBezierPath(roundedRect:self.bounds, byRoundingCorners:[.allCorners], cornerRadii: CGSize(width: 10, height: 10))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
