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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //設定Delegate後,才能放大縮小
        //同時也要實作function
        scrollViewMRTMap.delegate = self
        
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func backItemButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        //設定ScrollView 大小
        scrollViewMRTMap.contentSize = CGSize(width: viewContainerForMRTImageAndButton.frame.width  , height: viewContainerForMRTImageAndButton.frame.height)
        //設定ScrollView縮放
        scrollViewMRTMap.setZoomScale(0.5, animated: false)
        scrollViewMRTMap.minimumZoomScale = 0.5
        scrollViewMRTMap.maximumZoomScale = 1
        //移到台北車站
        scrollViewMRTMap.setContentOffset(CGPoint(x: 150, y: 300), animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {


    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
