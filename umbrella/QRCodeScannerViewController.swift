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
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    let supportedBarCodes = [AVMetadataObjectTypeQRCode, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeUPCECode, AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeAztecCode]
    var isRent = true //是否可借用的狀態檢查,若可租借,顯示true,否則false不要顯示鏡頭
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var currentNavigationController:UINavigationController?
    var currentViewController:UIViewController?
    var loginViewController:LoginOutViewController?
    var isFirstStart = "First"
    
    //tabbar切換一定要在viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        print("ViewDidAppear")
        
        if (appDelegate.jsonBackToken == "") || (appDelegate.jsonBackUserID == ""){
            print("跳入其他頁面")
           if loginViewController == nil {
            loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginOutViewController") as! LoginOutViewController
            loginViewController?.whoSend = "QRCodePage"
            //present(loginViewController, animated: true, completion: nil)
            self.tabBarController?.selectedIndex = 4
                currentNavigationController = self.tabBarController?.selectedViewController as! UINavigationController
                currentViewController = currentNavigationController?.topViewController
                currentViewController?.navigationController?.pushViewController(loginViewController!, animated: true)
            }else{
                print("已經存在")
          //  print(currentViewController)
           // currentViewController?.performSegue(withIdentifier: "gotoLoginPage", sender: nil)
            currentViewController?.navigationController?.pushViewController(loginViewController!, animated: true)
            //self.navigationController?.pushViewController(loginViewController, animated: true)//不行
            }
        }else{
            
            let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
            
            do {
                if isRent{
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
              }
            } catch {
                // If any error occurs, simply print it out and don't continue any more.
                print(error)
                return
            }
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Steven協助
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if (appDelegate.jsonBackToken != "") || (appDelegate.jsonBackUserID ~= ""){
         if isRent {
        qrCodeFrameView = UIView()
        //qrCodeFrameView?.frame = CGRect(x:imageForQRCodeScan.frame.origin.x , y: imageForQRCodeScan.frame.origin.y, width: imageForQRCodeScan.frame.width, height: imageForQRCodeScan.frame.height)
        qrCodeFrameView?.frame.origin.x = imageForQRCodeScan.frame.origin.x
        qrCodeFrameView?.frame.origin.y = imageForQRCodeScan.frame.origin.y
        print("viewWillLayoutSubviews")
       
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        print(videoPreviewLayer?.frame)
        print(view.layer.bounds)
        //            videoPreviewLayer?.frame = view.layer.bounds
        //設定掃瞄QRCode的視窗
        videoPreviewLayer?.frame = CGRect(x: imageForQRCodeScan.frame.origin.x, y: imageForQRCodeScan.frame.origin.y, width: imageForQRCodeScan.frame.width, height: imageForQRCodeScan.frame.height)
        print("1.------>",imageForQRCodeScan)
        view.layer.addSublayer(videoPreviewLayer!)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
                let paramString = "auth_token=\(a)&user_id=\(b)&id=\(c)"
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
                            self.sv = self.sqrvc?.view
                            self.view.addSubview(self.sv!)
                            self.addChildViewController(self.sqrvc!)
                            self.sqrvc?.didMove(toParentViewController: self)
                            self.isRent = false
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


