//
//  HistoryCellFooter.swift
//  umbrella
//
//  Created by  shawn on 02/01/2017.
//  Copyright © 2017 shawn. All rights reserved.
//

import UIKit

class HistoryCellFooter: UIView {
    
    override func layoutSubviews() {
        let path = UIBezierPath(roundedRect:self.bounds, byRoundingCorners:[.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 10, height: 10))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
}
