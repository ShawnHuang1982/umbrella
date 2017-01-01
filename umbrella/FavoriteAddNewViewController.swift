//
//  FavoriteAddNewViewController.swift
//  umbrella
//
//  Created by  shawn on 01/01/2017.
//  Copyright © 2017 shawn. All rights reserved.
//

import UIKit

class FavoriteAddNewViewController: UIViewController {
    
    @IBOutlet weak var scrollViewMRTMap: UIScrollView!
    @IBOutlet weak var viewContainerForMRTImageAndButton: UIView!
    var arrayStationFavoriteOrange = [String]() //
     var arrayStationFavoriteRed = [String]() //站名
     var arrayStationFavoriteGreen = [String]() //站名
     var arrayStationFavoriteBrown = [String]() //站名
     var arrayStationFavoriteBlue = [String]() //站名
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //設定Delegate後,才能放大縮小
        //同時也要實作function
        scrollViewMRTMap.delegate = self
        // Do any additional setup after loading the view.
    }

   
    override func viewWillAppear(_ animated: Bool) {
        //設定ScrollView 大小
        scrollViewMRTMap.contentSize = CGSize(width: viewContainerForMRTImageAndButton.frame.width, height: viewContainerForMRTImageAndButton.frame.height)
        //設定ScrollView縮放
        scrollViewMRTMap.setZoomScale(0.5, animated: false)
        scrollViewMRTMap.minimumZoomScale = 0.5
        scrollViewMRTMap.maximumZoomScale = 1
        //移到台北車站
        scrollViewMRTMap.setContentOffset(CGPoint(x: 150, y: 300), animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backItemButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
   
    //橘線儲存到我的最愛
    @IBAction func buttonStationPressOrangeLine(_ sender: UIButton) {
        print(sender.currentTitle)
        //讀檔
        if let loadedArrayOrange = UserDefaults.standard.stringArray(forKey: "myFavoriteOrange"){
            arrayStationFavoriteOrange = loadedArrayOrange
            var counter = 0
            if arrayStationFavoriteOrange.count == 0{
                print("a橘線第一次新增")
                arrayStationFavoriteOrange.append(sender.currentTitle!)
            }else{
            print("準備進入橘線迴圈檢查")
            for (index,station) in arrayStationFavoriteOrange.enumerated() {
                if station == sender.currentTitle{
                    print("橘線已有重複站名")
                    counter += 1
                }
                if (index == (arrayStationFavoriteOrange.count-1)) && (counter==0){
                    print("橘線沒有重複站名,增加站名")
                    arrayStationFavoriteOrange.append(sender.currentTitle!)
                }
            }
            }
        }else{
            print("b橘線第一次新增")
            arrayStationFavoriteOrange.append(sender.currentTitle!)
        }
        //存檔
        UserDefaults.standard.set(self.arrayStationFavoriteOrange, forKey: "myFavoriteOrange")
        //同步
        UserDefaults.standard.synchronize()
    }
    
    //紅線儲存到我的最愛
    @IBAction func buttonStationPressRedLine(_ sender: UIButton) {
        print(sender.currentTitle)
        //讀檔
        if let loadedArrayRed = UserDefaults.standard.stringArray(forKey: "myFavoriteRed"){
            arrayStationFavoriteRed = loadedArrayRed
            var counter = 0
            if arrayStationFavoriteRed.count == 0{
                print("a紅線第一次新增")
                arrayStationFavoriteRed.append(sender.currentTitle!)
            }else{
            for (index,station) in arrayStationFavoriteRed.enumerated() {
                if station == sender.currentTitle{
                    print("紅線已有重複站名")
                     counter += 1
                }
                if (index == (arrayStationFavoriteRed.count-1)) && (counter==0){
                    print("紅線沒有重複站名,增加站名")
                arrayStationFavoriteRed.append(sender.currentTitle!)
                }
            }
        }
        }else{
            print("b紅線第一次新增")
            arrayStationFavoriteRed.append(sender.currentTitle!)
        }
        //存檔
        UserDefaults.standard.set(self.arrayStationFavoriteRed, forKey: "myFavoriteRed")
        //同步
        UserDefaults.standard.synchronize()
    }

    //棕線儲存到我的最愛
    @IBAction func buttonStationPressBrownLine(_ sender: UIButton) {
        print(sender.currentTitle)
        //讀檔
        if let loadedArrayBrown = UserDefaults.standard.stringArray(forKey: "myFavoriteBrown"){
            arrayStationFavoriteBrown = loadedArrayBrown
            var counter = 0
            if arrayStationFavoriteBrown.count == 0{
                print("a棕線第一次新增")
                arrayStationFavoriteBrown.append(sender.currentTitle!)
            }else{
            for (index,station) in arrayStationFavoriteBrown.enumerated() {
                if station == sender.currentTitle{
                    print("棕線已有重複站名")
                    counter += 1
                }
                if (index == (arrayStationFavoriteBrown.count-1)) && (counter==0){
                    print("棕線沒有重複站名,增加站名")
                    arrayStationFavoriteBrown.append(sender.currentTitle!)
                }
            }
        }
        }else{
            print("b棕線第一次新增")
            arrayStationFavoriteBrown.append(sender.currentTitle!)
        }
        //存檔
        UserDefaults.standard.set(self.arrayStationFavoriteBrown, forKey: "myFavoriteBrown")
        //同步
        UserDefaults.standard.synchronize()
    }
    
    //綠線儲存到我的最愛
    @IBAction func buttonStationPressGreenLine(_ sender: UIButton) {
        print(sender.currentTitle)
        //讀檔
        if let loadedArrayGreen = UserDefaults.standard.stringArray(forKey: "myFavoriteGreen"){
            arrayStationFavoriteGreen = loadedArrayGreen
            var counter = 0
            if arrayStationFavoriteGreen.count == 0{
                print("a綠線第一次新增")
                arrayStationFavoriteGreen.append(sender.currentTitle!)
            }else{
            for (index,station) in arrayStationFavoriteGreen.enumerated() {
                if station == sender.currentTitle{
                    print("綠線已有重複站名")
                    counter += 1
                }
                if (index == (arrayStationFavoriteGreen.count-1)) && (counter==0){
                    print("綠線沒有重複站名,增加站名")
                    arrayStationFavoriteGreen.append(sender.currentTitle!)
                }
              }
            }
        }else{
            print("b綠線第一次新增")
            arrayStationFavoriteGreen.append(sender.currentTitle!)
        }
        //存檔
        UserDefaults.standard.set(self.arrayStationFavoriteGreen, forKey: "myFavoriteGreen")
        //同步
        UserDefaults.standard.synchronize()
    }
    
    //藍線儲存到我的最愛
    @IBAction func buttonStationPressBlueLine(_ sender: UIButton) {
        print(sender.currentTitle)
        //讀檔
        if let loadedArrayBlue = UserDefaults.standard.stringArray(forKey: "myFavoriteBlue"){
            arrayStationFavoriteBlue = loadedArrayBlue
            var counter = 0
            if arrayStationFavoriteBlue.count == 0{
                print("a藍線第一次新增")
                arrayStationFavoriteBlue.append(sender.currentTitle!)
            }else{
            for (index,station) in arrayStationFavoriteBlue.enumerated() {
                if station == sender.currentTitle{
                    print("藍線已有重複站名")
                    counter += 1
                }
                if (index == (arrayStationFavoriteBlue.count-1)) && (counter==0){
                    print("藍線沒有重複站名,增加站名")
                    arrayStationFavoriteBlue.append(sender.currentTitle!)
                }
            }
          }
        }else{
            print("b藍線第一次新增")
            arrayStationFavoriteBlue.append(sender.currentTitle!)
        }
        //存檔
        UserDefaults.standard.set(self.arrayStationFavoriteBlue, forKey: "myFavoriteBlue")
        //同步
        UserDefaults.standard.synchronize()
    }
    
}

extension FavoriteAddNewViewController:UIScrollViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print(#function)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print(#function)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        print(#function)
        //可以在ScorllView ZoominZoomOut
        return viewContainerForMRTImageAndButton
    }
    
    
    
}
