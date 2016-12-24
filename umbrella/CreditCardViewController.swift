//
//  CreditCardViewController.swift
//  umbrella
//
//  Created by  shawn on 20/12/2016.
//  Copyright © 2016 shawn. All rights reserved.
//

import UIKit
import NotificationCenter
import UserNotifications

class CreditCardViewController: UIViewController {

    @IBOutlet weak var textfieldCardNumberCRC: UITextField!
    @IBOutlet weak var textfieldCardNumber4: UITextField!
    @IBOutlet weak var textfieldCardNumber3: UITextField!
    @IBOutlet weak var textfieldCardNumber2: UITextField!
    @IBOutlet weak var textfieldCardNumber1: UITextField!
    @IBOutlet weak var viewContainer1: UIView!
    var checkCreditCard = "inValid"
    var MoveViewContainerStatus = "MoveDown"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(CreditCardViewController.keyboardWasShown), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(CreditCardViewController.keyboardWasBeHidden), name: .UIKeyboardWillHide, object: nil)
        print("firstMoveViewContainerStatus---->",MoveViewContainerStatus)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func buttonCreditCardSignUp(_ sender: Any) {
        
        // pop controller到上一層
        //        _ = navigationController?.popViewController(animated: true)
        
        // pop controller到 tabbar的那一層
        self.tabBarController?.selectedIndex = 1
          _ = navigationController?.popViewController(animated: true)
        
    }
    
    func keyboardWasShown(aNotification:Notification){
        if let keyboardSize = (aNotification.userInfo? [UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue{
            print("keyboardWasShown")
            print("鍵盤大小",keyboardSize.height)
            if MoveViewContainerStatus == "MoveDown"{
                print("a.",viewContainer1.frame.origin.y)
                viewContainer1.frame.origin.y -= (keyboardSize.height-50)
                print("b.",viewContainer1.frame.origin.y)
                MoveViewContainerStatus = "MoveUP"
            }
        }
    }
    
    
    func keyboardWasBeHidden(aNotification:Notification){
        if let keyboardSize = (aNotification.userInfo? [UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue{
            print("keyboardWasHidden")
            if MoveViewContainerStatus == "MoveUP"{
                print("c",viewContainer1.frame.origin.y)
            viewContainer1.frame.origin.y += (keyboardSize.height-50)
                print("d",viewContainer1.frame.origin.y)
            MoveViewContainerStatus = "MoveDown"
            }
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

}
//
//extension CreditCardViewController:UITextFieldDelegate{
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        print()
//    }
//    
//    
//}
