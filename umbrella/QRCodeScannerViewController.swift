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
    
    
    @IBOutlet weak var imageForQRCodeScan: UIView!
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    let supportedBarCodes = [AVMetadataObjectTypeQRCode, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeUPCECode, AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeAztecCode]
    var isRent = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)
            
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            
            captureMetadataOutput.metadataObjectTypes = supportedBarCodes
            
            
            captureSession?.startRunning()
            
//            view.bringSubview(toFront: messageLabel)
            
            qrCodeFrameView = UIView()
            
            if let qrCodeFrameView = qrCodeFrameView {
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 2
                view.addSubview(qrCodeFrameView)
                view.bringSubview(toFront: qrCodeFrameView)
            }
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if isRent {
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        print(videoPreviewLayer?.frame)
        print(view.layer.bounds)
        //            videoPreviewLayer?.frame = view.layer.bounds
        //設定掃瞄QRCode的視窗
        //imageForQRCodeScan.translatesAutoresizingMaskIntoConstraints = true
        videoPreviewLayer?.frame = CGRect(x: imageForQRCodeScan.frame.origin.x, y: imageForQRCodeScan.frame.origin.y, width: imageForQRCodeScan.frame.width, height: imageForQRCodeScan.frame.height)
        print("1.------>",imageForQRCodeScan)
        view.layer.addSublayer(videoPreviewLayer!)
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
            
            if (metadataObj.stringValue != nil) && (sqrvc == nil){
                print("uuuuuuuuuuu------")
//                messageLabel.text = metadataObj.stringValue
               // let sqrvc = self.storyboard?.instantiateViewController(withIdentifier: "QRCodeScanSuccessViewController") as! QRCodeScanSuccessViewController
                sqrvc = self.storyboard?.instantiateViewController(withIdentifier: "QRCodeScanSuccessViewController") as! QRCodeScanSuccessViewController
                sqrvc?.delegate = self
                print("2.------>",imageForQRCodeScan)
                //        svc.view.frame = self.view.bounds
                //      svc.delegate = metadataObj.stringValue
                sv = sqrvc?.view
                self.view.addSubview(sv!)
//                self.view.insertSubview(sv!, at: 0)
                isRent = false
                self.addChildViewController(sqrvc!)
                sqrvc?.didMove(toParentViewController: self)
            }
        }
    }
}

extension QRCodeScannerViewController:SuccessBackDelegate{
    func closeSuccessPage() {
//        self.videoPreviewLayer?.removeFromSuperlayer()
        sqrvc = nil
        print("yyyyyy")
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


