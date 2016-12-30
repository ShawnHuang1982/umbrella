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
        return deCodeJsonStationResultSorted.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //計算使用者位置與所有站點的距離
//        let cellLocation = CLLocation(latitude: deCodeJsonStationResult[indexPath.row].stationLat, longitude: deCodeJsonStationResult[indexPath.row].stationLon) //站點位置
//        print("站點的Location",cellLocation)
//        distanceInMeters = userLocation?.distance(from: cellLocation)
//        if distanceInMeters != nil{
//         let IntDistanceInMeters =  "\(Int(distanceInMeters!))"
//        testArray6.append(IntDistanceInMeters)
//        }
        //print("使用者離站點的距離",distanceInMeters)
        //print(cellLocation)
        //print(userLocation)
        //生出自訂的表格Cell
        let cell = Bundle.main.loadNibNamed("CustomStaionListTableViewCell", owner: self, options: nil)?.first as! CustomStaionListTableViewCell
        //print("在SearchStaionTableView cell----->",cell)
        cell.labelRouteName.text = deCodeJsonStationResultSorted[indexPath.row].stationName
        cell.labelNUBleftNumber.text = deCodeJsonStationResultSorted[indexPath.row].stationUmbrellaLeftNumber
//        if distanceInMeters != nil{
//        cell.labelLocationNearDistance.text = "\(Int(distanceInMeters!))"
//        }
        cell.labelLocationNearDistance.text = "\(deCodeJsonStationResultSorted[indexPath.row].distanceFromUserToStation)"
        print("aaa....>>>",deCodeJsonStationResultSorted[indexPath.row].stationRoute1ID)
        switch deCodeJsonStationResultSorted[indexPath.row].stationRoute1ID {
        case "淡水信義線":
            print("淡水信義線")
            cell.imageViewRouteColor.image = UIImage(named: "rRed")
        case "板南線":
            print("板南線")
            cell.imageViewRouteColor.image = UIImage(named: "rBlue")
        case "中和新蘆線":
            print("中和新蘆線")
            cell.imageViewRouteColor.image = UIImage(named: "rYellow")
        case "文湖線":
            print("文湖線")
            cell.imageViewRouteColor.image = UIImage(named: "rBrown")
        case "松山新店線":
            print("松山新店線")
            cell.imageViewRouteColor.image = UIImage(named: "rGreen")
        default:
            print("??線")
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
        //終於懂了為何要用performsegue
//        let vc2 = SearchStationDetailViewController()
//        self.navigationController?.pushViewController(vc2, animated: true)
        selectedName = deCodeJsonStationResultSorted[indexPath.row].stationName
            //建立地圖移動的座標
        selectedLocation = CLLocationCoordinate2DMake(deCodeJsonStationResultSorted[indexPath.row].stationLat, deCodeJsonStationResultSorted[indexPath.row].stationLon)
        
//        if distanceInMeters != nil {
//        selectedDistanceStationToLocation = "\(testArray6[indexPath.row])"}
        selectedDistanceStationToLocation = "\(deCodeJsonStationResultSorted[indexPath.row].distanceFromUserToStation)"
        selectedRouteName1 = deCodeJsonStationResultSorted[indexPath.row].stationRoute1ID
        selectedExit = testArray2[0]
        selectedUMBCanRent =  deCodeJsonStationResultSorted[indexPath.row].stationUmbrellaLeftNumber
        performSegue(withIdentifier: "gotoDetailStation", sender: nil)
        
 //       mapView.isHidden = false
 //       mapView.frame.size.height = 305
       // updateViewConstraints() //沒用
        

        //地圖有慢動作的移動
 //       self.callGoogleMap.animate(to: GMSCameraPosition.camera(withTarget: selectedLocation, zoom: 15))
//        CATransaction.commit()

        //設定Marker
 //       let marker = GMSMarker(position: selectedLocation)
 //       marker.map = callGoogleMap
 //       marker.title = testArray1[indexPath.row]
        //Marker title會一開始就顯示,不用點選Marker
 //       callGoogleMap.selectedMarker = marker
        
    }
    
    
    
}
