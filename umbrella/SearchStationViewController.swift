//
//  SearchStationViewController.swift
//  umbrella
//
//  Created by  shawn on 15/12/2016.
//  Copyright © 2016 shawn. All rights reserved.
//
// AutoLayout設定,ScrollView上:20,下:0,左:0,右:0 ; ContainView:水平spacing0,垂直置中,寬高800
// 設定手勢, 請看storyboard的gesture設定的Outlet有哪些
// 設定地圖, import GoogleMaps, 設定ios key, 及UIView宣告成GMSMap Class
// 移動畫面到座標 , 使用內建的CLLocationCoordinate2DMake func
import UIKit
import GoogleMaps

class SearchStationViewController: UIViewController{
    
        var locationManager = CLLocationManager() //取得使用者同意提供位置,及更新位置
    var userLocation:CLLocation? //取得使用者目前位置
    var selectedLocation = CLLocationCoordinate2D() //選取到的站點Location
    var selectedName = "" //選取到的站點名字
    var selectedExit = "" //選到的出口
    var selectedUMBCanRent = ""
    var selectedDistanceStationToLocation = ""
    var selectedRouteName1 = ""
    var selectedRouteName2 = ""
    var distanceInMeters:CLLocationDistance?
    
//    @IBOutlet weak var callGoogleMap: GMSMapView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableViewStationList: UITableView!
//    @IBOutlet weak var mapView: UIView!
    var testArray1 = ["松江南京","行天宮"]
    var testArray2 = ["4號出口地面出口處","1號出口方向驗票閘門處"]
    var testArray3 = ["5","15","10","10"]
    //var testArray4 = ["100","123"]    //假資料
    var testArray5lat = [25.0512257,25.059717]
    var testArray5lng = [121.5327387,121.533184]
     var data1 = [[String:String]]()
    var testArray6 = [String]()
    var testArray7 = ["松江南京線","板南線"]
    
//    @IBOutlet weak var viewForContainer: UIView!
//    @IBOutlet weak var scrollVewMRTMap: UIScrollView!
//    @IBOutlet weak var imageViewMRTMap: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //花很久時間才發現有autolayout的話 , 改變view的frame height,要加下面那句
 //       mapView.translatesAutoresizingMaskIntoConstraints = true
//        print("mapview的frame",mapView.frame)
//        print("view的大小",view.frame)
//        mapView.frame.size.height = 0
//        mapView.frame.size.width = view.frame.width //不加這句會跑掉?
        //tableview設定
        tableViewStationList.dataSource = self
        tableViewStationList.delegate = self
        
        //設定Delegate後,才能放大縮小
      //  scrollVewMRTMap.delegate = self
        
        //searchBar使用 偵測被點選的事件
        searchBar.delegate = self
        
        //要取得使用者位置,以下設定
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
 //       callGoogleMap.isMyLocationEnabled = true
        locationManager.delegate = self
         }

    override func viewDidDisappear(_ animated: Bool) {
        locationManager.stopUpdatingLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableViewStationList.needsUpdateConstraints()
//        print(imageViewMRTMap.frame)
//        print(imageViewMRTMap.bounds)
//        //設定ScrollView
//        scrollVewMRTMap.contentSize = CGSize(width: imageViewMRTMap.frame.width  , height: imageViewMRTMap.frame.height)
//        //scrollVewMRTMap.minimumZoomScale = 0.5
//        scrollVewMRTMap.setZoomScale(1, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoDetailStation"{
            if let destinationVC = segue.destination as? SearchStationDetailViewController{
                    destinationVC.getView1StationLocation = selectedLocation
                    destinationVC.getView1StationName = selectedName
                    destinationVC.getView1StationExit = selectedExit
                    destinationVC.getView1UMBCanRent = selectedUMBCanRent
                    destinationVC.getView1DistanceStationToLocation = selectedDistanceStationToLocation
                    destinationVC.getView1RouteName1 = selectedRouteName1
            }
        }
    }
    
    @IBAction func gestureTouchUp(_ sender: UISwipeGestureRecognizer) {
 //       mapView.frame.size.height = 0
        print("往上滑touchesup")
    }
    
    func requestData(){
        let urlString = "https://sheetsu.com/apis/v1.0/301105b950f0"
        let url = URL(string: urlString)
        let urlRequest = URLRequest(url: url!, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 30)
        print(urlRequest)
        let task = URLSession.shared.dataTask(with: urlRequest) {
            (data , responese , error )  in
            if error == nil {
                let res = responese as! HTTPURLResponse
                print("status:",res.statusCode)
                if let data = data {
                    do{
                        let str = String(data: data, encoding: .utf8)
                        print(str)
                        print(data)
                        try self.data1 = JSONSerialization.jsonObject(with: data) as! [[String : String]]
                        print(self.data1)
                        DispatchQueue.main.async {
                            self.testArray6 = []
                            self.tableViewStationList.reloadData()
                        }
                    }catch{
                        print(error)
                    }
                }
            }
        }
        task.resume()
        }

// last
}



//extension SearchStationViewController:UIScrollViewDelegate{
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        print(#function)
//    }

//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        print(#function)
//    }
    
//    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
//        print(#function)
//        //可以在ScorllView ZoominZoomOut
//        return viewForContainer
//    }
//}

extension SearchStationViewController:UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("點選SearchBar")
       // mapView.frame.size.height = 0
    }
}

extension SearchStationViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.first
        print("userLocation--->",userLocation)
        tableViewStationList.reloadData()   //為了更新使用者離站點的距離
    }
}




