//
//  SearchStationExtensionTableView.swift
//  umbrella
//
//  Created by  shawn on 21/12/2016.
//  Copyright © 2016 shawn. All rights reserved.
//

import Foundation
import UIKit

extension SearchStationViewController:UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArray1.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("CustomStaionListTableViewCell", owner: self, options: nil)?.first as! CustomStaionListTableViewCell
        print("cell----->",cell)
        
        
        
        cell.labelRouteName.text = testArray1[indexPath.row]
        cell.labelRouteExitName.text = testArray2[indexPath.row]
        cell.labelNUBleftNumber.text = testArray3[indexPath.row]
        cell.labelNUBCanMove.text  = testArray3[indexPath.row + 1]
        cell.labelLocationNearDistance.text = testArray4[indexPath.row]
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
}
