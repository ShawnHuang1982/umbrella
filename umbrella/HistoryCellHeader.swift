//
//  HistoryCellHeader.swift
//  umbrella
//
//  Created by  shawn on 02/01/2017.
//  Copyright © 2017 shawn. All rights reserved.
//

import UIKit

class HistoryCellHeader: UIView {
    
    override func layoutSubviews() {
        let path = UIBezierPath(roundedRect:self.bounds, byRoundingCorners:[.topLeft, .topRight], cornerRadii: CGSize(width: 20, height: 20))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
}
