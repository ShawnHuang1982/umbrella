//
//  SearchStationDetailViewController.swift
//  umbrella
//
//  Created by  shawn on 29/12/2016.
//  Copyright © 2016 shawn. All rights reserved.
//

import UIKit
import GoogleMaps

class SearchStationDetailViewController: UIViewController {


    @IBOutlet weak var labelRouteName: UILabel!
    @IBOutlet weak var btnFavorite: UIButton!
    @IBOutlet weak var labelLocationNearDistance: UILabel!
    @IBOutlet weak var labelUMBCanRent: UILabel!
    @IBOutlet weak var btnRoute: UIButton!
    @IBOutlet weak var labelStationExit: UILabel!
    @IBOutlet weak var labelStationName: UILabel!
    @IBOutlet weak var mapView: GMSMapView?
    @IBOutlet weak var stationDetail: UIView!
    var locationManager = CLLocationManager() //取得使用者同意提供位置,及更新位置
    var userLocation:CLLocation? //取得使用者目前位置
    var getView1StationLocation = CLLocationCoordinate2D()
    var getView1StationName = ""
    var getView1StationExit = ""
    var getView1UMBCanRent = "5"
    var getView1DistanceStationToLocation = "100"
    var getView1RouteName1 = "松山新店線"
    var getView1RouteName2 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white //有效
//       self.navigationController?.navigationItem.leftBarButtonItem?.title = "" //無效
//        self.navigationController?.navigationItem.backBarButtonItem?.title = ""   //無效
//        //        self.navigationItem.hidesBackButton = true //有效
        
        //self.navigationItem.backBarButtonItem?.title = " " //無效
        //        self.navigationItem.backBarButtonItem?.title = "" //無效
        //                self.navigationController?.navigationBar.backItem?.backBarButtonItem?.title = "BACK"
        //self.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        
      //  mapView?.delegate = self
        
        print("進入到SearchStationDetailViewController")
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        mapView?.isMyLocationEnabled = true
     }

    override func viewWillAppear(_ animated: Bool) {
        print("收到的location",getView1StationLocation)
        //地圖有慢動作的移動
               self.mapView?.animate(to: GMSCameraPosition.camera(withTarget: getView1StationLocation, zoom: 15))
                CATransaction.commit()
        //設定Marker
               let marker = GMSMarker(position: getView1StationLocation)
               marker.map = mapView
               marker.title = getView1StationName
        //Marker title會一開始就顯示,不用點選Marker
               mapView?.selectedMarker = marker
        //設定label
            labelStationName.text = getView1StationName
            labelStationExit.text = getView1StationExit
            labelUMBCanRent.text = getView1UMBCanRent
            labelLocationNearDistance.text = getView1DistanceStationToLocation
            labelRouteName.text = getView1RouteName1
        //設定button
            btnRoute.layer.cornerRadius =  10
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidDisappear(_ animated: Bool) {
        locationManager.stopUpdatingLocation()
    }
    
    @IBAction func buttonFavorite(_ sender: Any) {
    
    }
    
    @IBAction func buttonRoute(_ sender: Any) {
        
        
    }
    
    
    @IBAction func barItemBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchStationDetailViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         userLocation = locations.first
    }
}
