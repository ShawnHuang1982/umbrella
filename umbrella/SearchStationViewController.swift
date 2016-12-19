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
  
//    @IBOutlet weak var viewForContainer: UIView!
//    @IBOutlet weak var scrollVewMRTMap: UIScrollView!
//    @IBOutlet weak var imageViewMRTMap: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
