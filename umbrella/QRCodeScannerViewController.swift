//
//  QRCodeScannerViewController.swift
//  umbrella
//
//  Created by mac on 2016/12/15.
//  Copyright © 2016年 shawn. All rights reserved.
//

import UIKit
import AVFoundation


class QRCodeScannerViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    var sv:UIView? //給QRCode第二頁用的變數
    var sqrvc:QRCodeScanSuccessViewController?
    //之後要做鎖住相機的功能
    
    
    @IBOutlet weak var imageForQRCodeScan: UIView!
    @IBOutlet weak var container1Image: UIImageView!
    @IBOutlet weak var viewContainer1: UIView!
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    let supportedBarCodes = [AVMetadataObjectTypeQRCode, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeUPCECode, AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeAztecCode]
//    var isRent = true //是否可借用的狀態檢查,若可租借,顯示true,否則false不要顯示鏡頭
    var isStartCamera = false //相機是否已啟動
    var isLockViewStart = false //鎖住畫面是否啟動
    //var canRent = false //上網確認是否可租借傘
    var jsonPackage = [String:Any]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var currentNavigationController:UINavigationController?
    var currentViewController:SettingTableViewController?
    var loginViewController:LoginOutViewController?
    var isFirstStart = "First"
    
    override func viewDidDisappear(_ animated: Bool) {
         print("viewDidDisappear")
        loginViewController = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
         print("viewWillAppear")
        //為了轉場時不會看到背景畫面
        if (appDelegate.jsonBackToken == "") && (appDelegate.jsonBackUserID == "") && !(appDelegate.jsonCanRent){
            print("隱藏背景")
            viewContainer1.isHidden = true
            container1Image.isHidden = true
        } else if appDelegate.jsonCanRent{
            print("顯示背景")
            viewContainer1.isHidden = false
            container1Image.isHidden = false
        }
    }
    
    //tabbar切換一定要在viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        print("ViewDidAppear")
        //第一次載入
        if (appDelegate.jsonBackToken == "") && (appDelegate.jsonBackUserID == ""){
            print("準備進入登入頁面")
            if loginViewController == nil {
                loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginOutViewController") as! LoginOutViewController
                loginViewController?.whoSend = "QRCodePage"
                //present(loginViewController, animated: true, completion: nil)
                self.tabBarController?.selectedIndex = 4
                self.currentNavigationController = self.tabBarController?.selectedViewController as! UINavigationController
                self.currentViewController = self.currentNavigationController?.topViewController as! SettingTableViewController//settingTableViewController
                currentViewController?.whoSend = "QRCodeScanner"
                print("2----->",self.currentViewController)//settingTableViewController
                //增加動畫
                UIView.animate(withDuration: 1, animations: {
                    UIView.setAnimationCurve(.linear)
                    //推到下一個viewcontroller
                    self.currentViewController?.navigationController?.pushViewController(self.loginViewController!, animated: false)
                }
                )
            }else{
                //使用者點掃描,又選別的頁面,又點回掃描
                print("loginViewController已經存在,不需要再生一次")
                //  print(currentViewController)
                // currentViewController?.performSegue(withIdentifier: "gotoLoginPage", sender: nil)
                self.tabBarController?.selectedIndex = 4
                print("先跳到SettingTableViewController的位置",currentViewController)
                //增加動畫
                
                UIView.animate(withDuration: 1, animations: {
                    UIView.setAnimationCurve(.easeInOut)
                    self.currentViewController?.navigationController?.pushViewController(self.loginViewController!, animated: false)
                    }
                )
                //            self.navigationController?.pushViewController(loginViewController, animated: true)//不行
            }
        }
//        else if (appDelegate.jsonCanRent) && (appDelegate.jsonCanRentReady == "Ready"){
//            self.startScan()
//        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        _ = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(canRentCheck), userInfo: nil, repeats: true)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("viewWillLayoutSubviews")
//        print(appDelegate.jsonBackToken)
//        print(appDelegate.jsonBackUserID)
//        if (appDelegate.jsonBackToken != "") || (appDelegate.jsonBackUserID != ""){
//         if isRent {
//            //可以租借
//        qrCodeFrameView = UIView()
//        qrCodeFrameView?.frame = CGRect(x:imageForQRCodeScan.frame.origin.x , y: imageForQRCodeScan.frame.origin.y, width: imageForQRCodeScan.frame.width, height: imageForQRCodeScan.frame.height)
//        //qrCodeFrameView?.frame.origin.x = imageForQRCodeScan.frame.origin.x
//        //qrCodeFrameView?.frame.origin.y = imageForQRCodeScan.frame.origin.y
//        print("viewWillLayoutSubviews")
//       
//        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
//        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
//        print(videoPreviewLayer?.frame)
//        print(view.layer.bounds)
//        //            videoPreviewLayer?.frame = view.layer.bounds
//        //設定掃瞄QRCode的視窗
//        videoPreviewLayer?.frame = CGRect(x: imageForQRCodeScan.frame.origin.x, y: imageForQRCodeScan.frame.origin.y, width: imageForQRCodeScan.frame.width, height: imageForQRCodeScan.frame.height)
//        print("1.------>",imageForQRCodeScan)
//        view.layer.addSublayer(videoPreviewLayer!)
//            }
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func canRentCheck () {
        if (appDelegate.jsonBackUserID != "") && (appDelegate.jsonBackToken != ""){
        self.appDelegate.jsonCanRentReady = "NotReady"
        //先上網確認是否可租借
        let url = URL(string: "http://139.162.76.87/api/v1/umbrellas/borrow")
        var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 30)
        //  request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        //  let appDelegate = UIApplication.shared.delegate as! AppDelegate
        print(self.appDelegate)
        let a = self.appDelegate.jsonBackToken
        let b = self.appDelegate.jsonBackUserID
        print("canRentCheck中")
        print("a.token-->",a)
        print("b.userID-->",b)
        let paramString = "auth_token=\(a)&user_id=\(b)"
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        do {
            let task = URLSession.shared.dataTask(with: request) {
                (data, res, err) in
                let str = String(data: data!, encoding: .utf8)
                print("1.result---> \(res)")
                print("2.data--> \(str)")
                print("上網向後台確認是否可借傘------")
                try? self.jsonPackage = JSONSerialization.jsonObject(with: data!) as! [String : Any]
                print("json資料包",self.jsonPackage)
                let getCheck:Int = self.jsonPackage["borrow_status"] as! Int
                if getCheck == 1 {  //borrow_status狀態0代表不可借傘,狀態1代表可以借傘
                    print("可以借傘")
                    self.appDelegate.jsonCanRent = true
                    //self.canRent = true
                    self.appDelegate.jsonCanRentReady = "Ready"
                    self.isLockViewStart = false
                     DispatchQueue.main.async {
                    self.startScan() //可以借傘就可以展示掃描頁面
                    }
                }else{
                    print("不能租傘")
                    self.appDelegate.jsonCanRent = false
                    // self.canRent = false
                    self.appDelegate.jsonCanRentReady = "Ready"
                    //用performSgue建議用navigation,pop回來才比較沒問題
                //    self.presentingViewController?.performSegue(withIdentifier: "gotoRented", sender: nil) //不行
                    DispatchQueue.main.async {
                        self.pushLockView()
                    }
                }
            }
            task.resume()
        }
        catch {
        }
      }
    }
    
    func pushLockView(){
        if  !isLockViewStart{
        print("推到下一頁")
        isLockViewStart = true
        performSegue(withIdentifier: "gotoRented", sender: nil)
        }
    }
    
    func startScan(){
        //可以借傘
        print("啟動鏡頭")

        print("appDelegate.jsonCanRent--->",appDelegate.jsonCanRent)
        print("ppDelegate.jsonCanRentReady--->",appDelegate.jsonCanRentReady)
        print("isFirstStart--->",isFirstStart)
        if (appDelegate.jsonCanRent) &&
//            (isFirstStart == "First") &&
            (appDelegate.jsonCanRentReady == "Ready") && (videoPreviewLayer == nil) {
            print("QRCode掃描頁可借傘")
            //           print("先檢查是否可借傘",canRent)
            //登入後再檢查是否可借傘
            //            if canRent{
            //可以借傘
            //print("啟動鏡頭")
            let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
//            viewContainer1.isHidden = false
//            container1Image.isHidden = false
            do {
                //可以租借
//                if isRent{
                    // Get an instance of the AVCaptureDeviceInput class using the previous device object.
                    let input = try AVCaptureDeviceInput(device: captureDevice)
                    
                    captureSession = AVCaptureSession()
                    captureSession?.addInput(input)
                    
                    let captureMetadataOutput = AVCaptureMetadataOutput()
                    captureSession?.addOutput(captureMetadataOutput)
                    
                    captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                    captureMetadataOutput.metadataObjectTypes = supportedBarCodes
                    
                    //要把啟動相機掃描放在主執行緒用
                    DispatchQueue.main.async {
                        self.captureSession?.startRunning()
                    }
                    
                    //            view.bringSubview(toFront: messageLabel)
                    //qrCodeFrameView = UIView()
                    //對焦的view,綠色框框
                    if let qrCodeFrameView = qrCodeFrameView {
                        qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                        qrCodeFrameView.layer.borderWidth = 2
                        view.addSubview(qrCodeFrameView)
                        view.bringSubview(toFront: qrCodeFrameView)
                    }
 //               }
            } catch {
                // If any error occurs, simply print it out and don't continue any more.
                print(error)
                //return
            }
            
           // if (appDelegate.jsonBackToken != "") && (appDelegate.jsonBackUserID != "") {
   //             if isRent {
                    //可以租借
                    qrCodeFrameView = UIView()
                    qrCodeFrameView?.frame = CGRect(x:imageForQRCodeScan.frame.origin.x , y: imageForQRCodeScan.frame.origin.y, width: imageForQRCodeScan.frame.width, height: imageForQRCodeScan.frame.height)
                    //qrCodeFrameView?.frame.origin.x = imageForQRCodeScan.frame.origin.x
                    //qrCodeFrameView?.frame.origin.y = imageForQRCodeScan.frame.origin.y
            
          //  if videoPreviewLayer == nil{ //會當掉
                    videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                    videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
                    //print(videoPreviewLayer?.frame)
                    //print(view.layer.bounds)
                    //            videoPreviewLayer?.frame = view.layer.bounds
                    //設定掃瞄QRCode的視窗
                    videoPreviewLayer?.frame = CGRect(x: imageForQRCodeScan.frame.origin.x, y: imageForQRCodeScan.frame.origin.y, width: (imageForQRCodeScan.frame.width+20), height: (imageForQRCodeScan.frame.height+20) )
                    print("1.------>",imageForQRCodeScan)
                //if (videoPreviewLayer == nil){
                    view.layer.addSublayer(videoPreviewLayer!)
                //}
                    //self.isFirstStart = "Second"
        }else{
            //遇到回到掃描的視窗,會看不到底下的view
            print("已經有預覽視窗了")
            print(viewContainer1) //確定存在
            print(imageForQRCodeScan)    //確定存在
//                self.viewContainer1.isHidden = false  //一開始view都會被隱藏
//                self.container1Image.isHidden = false //一開始view都會被隱藏
        }
  //          }
  //      }
        
        //如果不能租借就鎖定畫面
//        if !(appDelegate.jsonCanRent) && (appDelegate.jsonBackToken != nil) && (appDelegate.jsonBackUserID != nil)&&(appDelegate.jsonCanRentReady == "Ready"){
//            print("鎖住畫面")
            //if (self.navigationController?.topViewController?.isEqual(QRCodeRentedViewController))!{
            //用performSgue建議用navigation,pop回來才比較沒問題
//          performSegue(withIdentifier: "gotoRented", sender: nil)
            //}
//        }

    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        if metadataObjects == nil || metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            
            //messageLabel.text = "No barcode/QR code is detected"
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if supportedBarCodes.contains(metadataObj.type) {
            //        if metadataObj.type == AVMetadataObjectTypeQRCode {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            //Ethon協助
            if (metadataObj.stringValue != nil) && (sqrvc == nil) && (isFirstStart == "First"){
                isFirstStart = "Second"
                print("傘的數值",metadataObj.stringValue)
                let checkAsNumber:Int? = Int(metadataObj.stringValue)
                    print("傘的number",checkAsNumber)
            if checkAsNumber != nil {
                //-> [String:Any] {
                let url = URL(string: "http://139.162.76.87/api/v1/umbrellas/borrow")
                var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 30)
              // request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpMethod = "POST"
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                print(appDelegate)
                let a = appDelegate.jsonBackToken
                let b = appDelegate.jsonBackUserID
                print("a-->",a)
                print("b-->",b)
                print("c-->",metadataObj.stringValue)
                let c = (metadataObj.stringValue)!
                let paramString = "auth_token=\(a)&user_id=\(b)&umbrella_number=\(c)"
                request.httpBody = paramString.data(using: String.Encoding.utf8)

                do {
                    let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
                        let str = String(data: data!, encoding: .utf8)
                        print("result---> \(res)")
                        print("data--> \(str)")
                        print("掃描到有值,而且是第一次產生下一頁------")
                        // messageLabel.text = metadataObj.stringValue
                        // let sqrvc = self.storyboard?.instantiateViewController(withIdentifier: "QRCodeScanSuccessViewController") as! QRCodeScanSuccessViewController
                        DispatchQueue.main.async {
                            self.sqrvc = self.storyboard?.instantiateViewController(withIdentifier: "QRCodeScanSuccessViewController") as! QRCodeScanSuccessViewController
                            self.sqrvc?.delegate = self
                            print("2.------>",self.imageForQRCodeScan)
                            // svc.view.frame = self.view.bounds
                            // svc.delegate = metadataObj.stringValue
                            self.viewContainer1.isHidden = true
                            self.container1Image.isHidden = true
                            self.sv = self.sqrvc?.view
                            self.view.addSubview(self.sv!)
                            self.addChildViewController(self.sqrvc!)
                            self.sqrvc?.didMove(toParentViewController: self)
//                            self.isRent = false
                        }
                    }
                    task.resume()
                }
                catch {
                    print(error)
                }
            }
        }
    }
    }
}

extension QRCodeScannerViewController:SuccessBackDelegate{
    func closeSuccessPage() {
        sqrvc = nil
        isFirstStart = "First"
        print("delegate執行可以再次掃描")
    }
}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


