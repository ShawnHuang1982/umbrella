//
//  SearchStationExtensionTableView.swift
//  umbrella
//
//  Created by  shawn on 21/12/2016.
//  Copyright © 2016 shawn. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

extension SearchStationViewController:UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArray1.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //計算使用者位置與所有站點的距離
        let cellLocation = CLLocation(latitude: testArray5lat[indexPath.row], longitude: testArray5lng[indexPath.row]) //站點位置
        let distanceInMeters = userLocation?.distance(from: cellLocation)
        print("使用者離站點的距離",distanceInMeters)
        print(cellLocation)
        print(userLocation)
        //生出自訂的表格Cell
        let cell = Bundle.main.loadNibNamed("CustomStaionListTableViewCell", owner: self, options: nil)?.first as! CustomStaionListTableViewCell
        print("cell----->",cell)
        cell.labelRouteName.text = testArray1[indexPath.row]
        cell.labelNUBleftNumber.text = testArray3[indexPath.row]
        if distanceInMeters != nil{
        
        cell.labelLocationNearDistance.text = "\(Int(distanceInMeters!))"
        }
        //cell.labelLocationNearDistance.sizeToFit()
        // updateViewConstraints()
        //點選表格不會變成灰色
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("點選的row:\(indexPath.row)")
        mapView.isHidden = false
        mapView.frame.size.height = 305
       // updateViewConstraints() //沒用
        
      //建立地圖移動的座標
        let selectedLocation = CLLocationCoordinate2DMake(testArray5lat[indexPath.row], testArray5lng[indexPath.row])
        //地圖有慢動作的移動
        self.callGoogleMap.animate(to: GMSCameraPosition.camera(withTarget: selectedLocation, zoom: 15))
        CATransaction.commit()

        //設定Marker
        let marker = GMSMarker(position: selectedLocation)
        marker.map = callGoogleMap
        marker.title = testArray1[indexPath.row]
        //Marker title會一開始就顯示,不用點選Marker
        callGoogleMap.selectedMarker = marker
        
    }
    
    
    
}
