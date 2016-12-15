//
//  SearchStationViewController.swift
//  umbrella
//
//  Created by  shawn on 15/12/2016.
//  Copyright © 2016 shawn. All rights reserved.
//

import UIKit

class SearchStationViewController: UIViewController {

    @IBOutlet weak var scrollVewMRTMap: UIScrollView!
    @IBOutlet weak var imageViewMRTMap: UIImageView!
    var fullSize:CGSize!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //scrollVewMRTMap.delegate = self
        
        
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
 //       fullSize = scrollVewMRTMap.frame.size
        print(imageViewMRTMap.frame)
        print(imageViewMRTMap.bounds)
        scrollVewMRTMap.contentSize = CGSize(width: imageViewMRTMap.frame.width    , height: imageViewMRTMap.frame.height)
//        scrollVewMRTMap.zoomScale = 2.0
        scrollVewMRTMap.setZoomScale(3.0, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: -
    //MARK: Button
    @IBAction func buttonStation(_ sender: UIButton) {
        print(sender.currentTitle)
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

extension ViewController:UIScrollViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print(#function)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print(#function)
    }
}
