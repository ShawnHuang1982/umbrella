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
import Alamofire
import SwiftyJSON

class SearchStationViewController: UIViewController{
    
   // @IBOutlet var searchController: UISearchDisplayController!  //等下要存要我們收尋資料的 SearchController
    var search1Controller:UISearchController! //等下要存要我們收尋資料的 SearchController
    var result1Controller = UITableViewController() //等下準備顯示搜尋結果的tableViewController
    
//    @IBOutlet weak var customSearchBar: UISearchBar!
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
    
    var distanceCalculate3 = 0
    var deCodeJsonStationResult = [StructStation]()
        var deCodeJsonStationResultSorted = [StructStation]()
   let appDelegate = UIApplication.shared.delegate as! AppDelegate //都是同一個
    var resultArray = [StructStation]()
//    var resultArray = [String]() //測試用
//    @IBOutlet weak var callGoogleMap: GMSMapView!
//    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableViewStationList: UITableView!
//    @IBOutlet weak var mapView: UIView!
    var tmpArray = [""]
    var testArray1 = ["222松江南京","223行天宮"]
    var testArray2 = ["驗票閘門處","4號出口地面出口處","1號出口方向驗票閘門處"]
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
        //searchBar.delegate = self
        //customSearchBar.delegate = self
        
        
        //要取得使用者位置,以下設定
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
 //       callGoogleMap.isMyLocationEnabled = true
        locationManager.delegate = self
        
        //設定SearchBarController
        search1Controller = UISearchController(searchResultsController: result1Controller)
        
        search1Controller.searchBar.barTintColor = UIColor(red: 0.953, green: 0.957, blue: 0.961, alpha: 1)
        search1Controller.searchBar.backgroundColor = UIColor.clear
        result1Controller.automaticallyAdjustsScrollViewInsets = false
        result1Controller.tableView.contentInset = UIEdgeInsetsMake(search1Controller.searchBar.frame.height + 20 , 0, 0, 0)
        search1Controller.searchResultsUpdater = self
        tableViewStationList.tableHeaderView = search1Controller.searchBar
        result1Controller.tableView.delegate = self
        result1Controller.tableView.dataSource = self
        search1Controller.dimsBackgroundDuringPresentation = false
        
        
        print("上網抓站點資料")
        requestData()
        
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
    
    
    
    //進入到站點詳細的頁面要送入的資料
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
        
        tmpArray = []
        deCodeJsonStationResultSorted = []
        
        let urlString = "http://139.162.76.87/api/v1/stations"
        let parameter:Parameters = [
            "auth_token" : appDelegate.jsonBackToken,
            "user_id":appDelegate.jsonBackUserID
        ]
        Alamofire.request(urlString, parameters: parameter).responseJSON {
            (response) in
            switch response.result{
            case .success:
                let jsonPackage = JSON(response.result.value)
                //print("站點傘數量json資料包",json)
                let jsonArrayAllLocation = jsonPackage["all_locations"].arrayValue
                //print("所有站點json資料包",jsonArrayAllLocation)
                //  let jsonArrayLocationName = jsonArrayAllLocation.first?["location_name"].stringValue
                for i in 0...jsonArrayAllLocation.count-1{
                    let jsonArrayLocationName = jsonArrayAllLocation[i]["location_name"].stringValue ?? ""
                    let jsonArrayLocationLat = (jsonArrayAllLocation[i]["location_coordinate"]["latitude"]).doubleValue
                    let jsonArrayLocationLon = (jsonArrayAllLocation[i]["location_coordinate"]["longitude"]).doubleValue
                    let jsonArrayLocationPlaceID = jsonArrayAllLocation[i]["location_id"].stringValue ?? ""
                    let jsonArrayLocationRoute1a = jsonArrayAllLocation[i]["mrt_line"].arrayValue
                   let jsonArrayLocationRoute1b = jsonArrayLocationRoute1a.first?["line_name"].stringValue ?? ""
                    let jsonArrayLocationUMBNumber = jsonArrayAllLocation[i]["rentable_umbrella_number"].stringValue ?? ""
                   let distanceCalculate1 = CLLocation(latitude: jsonArrayLocationLat, longitude: jsonArrayLocationLon)
                    let distanceCalculate2 = self.userLocation?.distance(from: distanceCalculate1)
                    if distanceCalculate2 != nil{
                        self.distanceCalculate3 =  Int(distanceCalculate2!)
                    }
                    
                    //let jsonArrayLocationRoute1c = jsonArrayLocationRoute1a.
//                    if let jsonArrayLocationRoute1b = jsonArrayLocationRoute1a[1]["line_name"]
//                    print("站點ID",jsonArrayLocationPlaceID)
//                    print("站點名稱",jsonArrayLocationName)
//                    print("站點經度",jsonArrayLocationLat)
//                    print("站點緯度",jsonArrayLocationLon)
//                    print("站點路線1",jsonArrayLocationRoute1b)
                    //print("站點路線1",jsonArrayLocationRoute1b)
                    self.deCodeJsonStationResult.append(StructStation(stationPlaceID: jsonArrayLocationPlaceID , stationName: jsonArrayLocationName, stationLat: jsonArrayLocationLat, stationLon: jsonArrayLocationLon, stationUmbrellaLeftNumber: jsonArrayLocationUMBNumber, stationRoute1ID: jsonArrayLocationRoute1b, stationRoute2ID: "" , distanceFromUserToStation: self.distanceCalculate3))
                }
             //   print(self.deCodeJsonStationResult.count)
              //  print(self.deCodeJsonStationResult)
                
                DispatchQueue.main.async {
                    //儲存按照遠近的排序後的資料
                   self.deCodeJsonStationResultSorted = self.deCodeJsonStationResult.sorted(by: { (lhs:StructStation, rhs:StructStation) -> Bool in
                    return lhs.distanceFromUserToStation < rhs.distanceFromUserToStation
                    // return lhs.distanceFromUserToStation > rhs.distanceFromUserToStation
                        //return lhs.distanceFromUserToStation.compare(rhs.distanceFromUserToStation) == .orderedDescending
                    })
                    //一開始不會解struct的filter function
//     for index in 0...self.deCodeJsonStationResultSorted.count-1{
//                       self.tmpArray.append( self.deCodeJsonStationResultSorted[index].stationName)
//                    }
                    print(self.deCodeJsonStationResultSorted)
                    self.tableViewStationList.reloadData()
                }
                
                
            case .failure(let error):
                print(error)
                
            }
        }
        
        
        
        
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
        //print("userLocation--->",userLocation)
        tableViewStationList.reloadData()   //為了更新使用者離站點的距離
    }
}

extension SearchStationViewController:UISearchResultsUpdating{

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.search1Controller.searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
    }
    
    //實行這個updateSearchResults,就可以在SearchBar
    func updateSearchResults(for searchController: UISearchController) {
        if let searchWord = searchController.searchBar.text{
            //測試用
//            resultArray = tmpArray.filter({
//                (product:String) -> Bool in
//                product.contains(searchWord)
//                return product.lowercased().contains(searchWord.lowercased())
//            })
            
            //struct格式 by steven
//            resultArray = deCodeJsonStationResultSorted.filter(){
//                ($0 as StructStation).stationName.contains(searchWord)
//                                (station:StructStation) -> Bool in
//                                station.stationName.contains(searchWord)
//                                return station.stationName.contains
//            )}
            
            //struct格式
            resultArray = deCodeJsonStationResultSorted.filter{
                $0.stationName.contains(searchWord)
            }
                print("過濾結果",resultArray)
                result1Controller.tableView.reloadData()
        }
    }
}



