//
//  QRCodeScanSuccessViewController.swift
//  umbrella
//
//  Created by  shawn on 20/12/2016.
//  Copyright © 2016 shawn. All rights reserved.
//

import UIKit

protocol SuccessBackDelegate {
    func closeSuccessPage()
}

class QRCodeScanSuccessViewController: UIViewController {
    var delegate:SuccessBackDelegate?
    var valueQRCode = ""
    @IBAction func buttonForClean(_ sender: Any) {
        self.willMove(toParentViewController: nil)
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
        delegate?.closeSuccessPage()
    }
//    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("touches")
//        print(self)
//        print(self.parent)
//        //delegate?.closeSuccessPage()
////        self.willMove(toParentViewController: nil)
//        
////        DispatchQueue.main.async {
////            self.view.removeFromSuperview()
////            self.removeFromParentViewController()
//    //    }
//    
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
