//
//  CustomFavortieHeaderTableViewCell.swift
//  umbrella
//
//  Created by  shawn on 19/12/2016.
//  Copyright © 2016 shawn. All rights reserved.
//

import UIKit

protocol editMyFavoriteStationDelegate {
    func editMyFavoriteStation()
    func cancelActionMyFavortieStation()
    func didFinishMyFavortieStation()
}


class CustomFavortieHeaderTableViewCell: UITableViewCell {
    var delegate:editMyFavoriteStationDelegate?
    
    var isFirstDisplay = false
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnDidFinish: UIButton!
    @IBOutlet weak var viewInCell: UIView!
    @IBOutlet weak var labelFavoriteStation: UILabel!
    var viewInCellCopy = CALayer()
    
    
    @IBAction func buttonCancel(_ sender: Any) {
        print("upup")
        delegate?.cancelActionMyFavortieStation()
        btnEdit.isHidden = false
        btnCancel.isHidden = true
        btnDidFinish.isHidden = true

    }
    @IBAction func buttonDidFinish(_ sender: Any) {
         print("gogogo")
        delegate?.didFinishMyFavortieStation()
        btnEdit.isHidden = false
        btnCancel.isHidden = true
        btnDidFinish.isHidden = true
    }

    
    
    
    @IBAction func buttonEditFavoriteStation(_ sender: UIButton) {
        print("yaya")
        delegate?.editMyFavoriteStation()
        btnEdit.isHidden = true
        btnCancel.isHidden = false
        btnDidFinish.isHidden = false
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewInCell.layer.shadowOffset = CGSize(width: 0, height: 0)
        viewInCell.layer.shadowRadius = 4
        viewInCell.layer.shadowColor = UIColor.black.cgColor
        viewInCell.layer.shadowOpacity = 0.25
        viewInCell.layer.masksToBounds = false
       
        
//        let maskLayer = CAShapeLayer()
//        maskLayer.frame = viewInCell.bounds
//        maskLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: UIRectCorner.topLeft.union(.topRight), cornerRadii: CGSize(width: 10, height: 10)).cgPath
//        self.layer.mask = maskLayer
   
//        let rectShape = CAShapeLayer()
//        rectShape.bounds = self.viewInCell.frame
//        rectShape.position = self.viewInCell.center
//        rectShape.path = UIBezierPath(roundedRect:viewInCell.bounds, byRoundingCorners:[.topLeft], cornerRadii: CGSize(width: 10, height:  10)).cgPath
//        viewInCell.layer.mask = rectShape
        
//        let path = UIBezierPath(roundedRect:viewInCell.bounds,
//                                byRoundingCorners:[.allCorners],
//                                cornerRadii: CGSize(width: 10, height:  10))
//        let maskLayer = CAShapeLayer()
//        maskLayer.path = path.cgPath
//        viewInCell.layer.mask = maskLayer
        
    //   viewInCell.layer.cornerRadius = 10
        
        
        // Initialization code
    }
    
    override func layoutSubviews() {
        print("開始layoutSubViews")
//                let path = UIBezierPath(roundedRect:viewInCell.bounds,
//                                        byRoundingCorners:[.allCorners],
//                                        cornerRadii: CGSize(width: 10, height:  10))
//                let maskLayer = CAShapeLayer()
//                maskLayer.path = path.cgPath
//                viewInCell.layer.mask = maskLayer
        
   //     print("a--->",isFirstDisplay)
   //     if !isFirstDisplay{
//            print("b--->",isFirstDisplay)
//        print("aa",viewInCell.bounds)
//            let path = UIBezierPath(roundedRect:viewInCell.bounds, byRoundingCorners:[.topLeft, .topRight], cornerRadii: CGSize(width: 10, height: 10))
//        let maskLayer = CAShapeLayer()
//        maskLayer.frame = viewInCell.bounds
//        maskLayer.path = path.cgPath
//    
//        print("bb",viewInCell.layer.mask)
        
       // if viewInCellCopy != nil {
//        viewInCell.layer.mask = maskLayer
//            print("cc",viewInCell.layer.mask)
//        isFirstDisplay = true
       // }
       // }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
