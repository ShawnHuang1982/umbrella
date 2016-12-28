//
//  QRCodeRentedViewController.swift
//  umbrella
//
//  Created by  shawn on 27/12/2016.
//  Copyright © 2016 shawn. All rights reserved.
// 在租借頁面也要不斷確認是否可租借, canRentCheck方法

import UIKit

class QRCodeRentedViewController: UIViewController {

   // var canRent = 0
    var jsonCheckCanRent = [String:Any]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var myTimer1 = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("在qrcodeRent")
        myTimer1 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(checkAndBack), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkAndBack(){
        canRentCheck()
        print("租用中頁面")
    if self.appDelegate.jsonCanRent{
        print("租用中頁面,回到上一頁")
        myTimer1.invalidate()
        self.navigationController?.popViewController(animated: true)
//        self.popoverPresentationController
        }
    }
    
    func canRentCheck () {
        //先上網確認是否可租借
        let url = URL(string: "http://139.162.76.87/api/v1/umbrellas/borrow")
        var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 30)
        //  request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
    //    let appDelegate = UIApplication.shared.delegate as! AppDelegate
        print(appDelegate)
        let a = appDelegate.jsonBackToken
        let b = appDelegate.jsonBackUserID
        print("a-->",a)
        print("b-->",b)
        let paramString = "auth_token=\(a)&user_id=\(b)"
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        do {
            let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
                let str = String(data: data!, encoding: .utf8)
                //print("1.result---> \(res)")
                //print("2.data--> \(str)")
                print("上網向後台確認是否可借傘------")
                try? self.jsonCheckCanRent = JSONSerialization.jsonObject(with: data!) as! [String : Any]
                print("json資料包",self.jsonCheckCanRent)
                let getCheck:Int = self.jsonCheckCanRent["borrow_status"] as! Int
                if getCheck == 1{
                    print("可以借傘")
                    self.appDelegate.jsonCanRent = true
                    //self.canRent = true
//                    self.canRent = 1
                }else{
                    self.appDelegate.jsonCanRent = false
                    // self.canRent = false
//                    self.canRent = 0
                }
            }
            task.resume()
        }
        catch {
            print(error)
        }
    }

}
