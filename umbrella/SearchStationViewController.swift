//
//  SearchStationViewController.swift
//  umbrella
//
//  Created by  shawn on 15/12/2016.
//  Copyright © 2016 shawn. All rights reserved.
//
// AutoLayout設定,ScrollView上:20,下:0,左:0,右:0 ; ContainView:水平spacing0,垂直置中,寬高800

import UIKit

class SearchStationViewController: UIViewController{
  
    @IBOutlet weak var tableViewStationList: UITableView!
    @IBOutlet weak var mapView: UIView!
    var testArray1 = ["松江南京","行天宮"]
    var testArray2 = ["4號出口地面出口處","1號出口方向驗票閘門處"]
    var testArray3 = ["5","15","10","10"]
    var testArray4 = ["100公尺","123公尺"]
     var data1 = [[String:String]]()
    
//    @IBOutlet weak var viewForContainer: UIView!
//    @IBOutlet weak var scrollVewMRTMap: UIScrollView!
//    @IBOutlet weak var imageViewMRTMap: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //花很久時間才發現有autolayout的話 , 改變view的frame height,要加下面那句
        mapView.translatesAutoresizingMaskIntoConstraints = true
        print("mapview的frame",mapView.frame)
        print("view的大小",view.frame)
        mapView.frame.size.height = 0
        mapView.frame.size.width = view.frame.width //不加這句會跑掉?
        
        //tableview設定
        tableViewStationList.dataSource = self
        tableViewStationList.delegate = self
        
        //設定Delegate後,才能放大縮小
      //  scrollVewMRTMap.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        
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
    
    //MARK: -
    //MARK: Button
//    @IBAction func buttonStation(_ sender: UIButton) {
//       // print(sender.currentTitle)
//    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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


