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
    @IBOutlet weak var rentView: UIImageView!
    var delegate:SuccessBackDelegate?
    var valueQRCode = ""
    var changingView = "SuccessView"
    var myTimer:Timer?
    
    func cleanView() {
        self.willMove(toParentViewController: nil)
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
        delegate?.closeSuccessPage()
    }
    
    func makeRentView(){
        print("增加RentView")
        changingView = "RentView"
        rentView.isHidden = false
    }
    
    
//    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if changingView == "RentView" {
            //之後要加判斷,去後台確認是否可以在租借新的傘
            cleanView()
        }
        
        print("touches")
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rentView.isHidden = true
        if changingView == "SuccessView"{
            print("增加SuccessView")
            myTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(QRCodeScanSuccessViewController.makeRentView), userInfo: nil, repeats: false)
            print("myTimer",myTimer)
        }

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
