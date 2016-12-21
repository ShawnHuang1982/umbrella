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
    
 
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnDidFinish: UIButton!
    @IBOutlet weak var viewInCell: UIView!
    @IBOutlet weak var labelFavoriteStation: UILabel!
    
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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
