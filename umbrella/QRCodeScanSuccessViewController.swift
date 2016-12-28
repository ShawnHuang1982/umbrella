//
//  QRCodeScanSuccessViewController.swift
//  umbrella
//
//  Created by  shawn on 20/12/2016.
//  Copyright © 2016 shawn. All rights reserved.
// 顯示租借成功3秒後回到首頁,此時會看到租借中的畫面已推上來

import UIKit

protocol SuccessBackDelegate {
    func closeSuccessPage()
}

class QRCodeScanSuccessViewController: UIViewController {
//    @IBOutlet weak var rentView: UIImageView!
    var delegate:SuccessBackDelegate?
    var valueQRCode = ""
    var changingView = "SuccessView"
    var myTimer:Timer?
    var jsonCheckCanRent = [String:Any]()

    override func viewDidLoad() {
        super.viewDidLoad()
//        rentView.isHidden = true
        if changingView == "SuccessView"{
            print("增加SuccessView")
            myTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(QRCodeScanSuccessViewController.cleanView), userInfo: nil, repeats: false)
            print("myTimer",myTimer)
        }
//        _ = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(canRentCheck), userInfo: nil, repeats: true)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if changingView == "RentView" {
            //之後要加判斷,去後台確認是否可以在租借新的傘
            // cleanView()
        }
        print("touches")
        //        print(self)
        //        print(self.parent)
        //        //delegate?.closeSuccessPage()
        //        self.willMove(toParentViewController: nil)
        //
        //        DispatchQueue.main.async {
        //            self.view.removeFromSuperview()
        //            self.removeFromParentViewController()
        //        }
        //    
    }
    
    
    func cleanView() {
        self.willMove(toParentViewController: nil)
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
        delegate?.closeSuccessPage()
    }
    
//    func makeRentView(){
//        print("增加RentView")
//        changingView = "RentView"
//        rentView.isHidden = false
//    }
    
}
