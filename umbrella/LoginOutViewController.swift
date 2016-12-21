//
//  LoginOutViewController.swift
//  umbrella
//
//  Created by  shawn on 20/12/2016.
//  Copyright © 2016 shawn. All rights reserved.
//

import UIKit

class LoginOutViewController: UIViewController {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var labelPassword: UILabel!
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var textfieldUserPassword: UITextField!
    @IBOutlet weak var textfieldUserName: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var labelForUserNameDidLogin: UILabel!
    
    var isLoginStatus = "logout"

    override func viewDidLoad() {
        super.viewDidLoad()
        print("isLoginStatus",isLoginStatus)
        if  isLoginStatus == "Login"{
            showLogoutUI()
        }else{
            showLoginUI()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonLogin(_ sender: Any) {
        let tempClean1 = (textfieldUserName.text)?.replacingOccurrences(of: " ", with: "")
        let tempClean2 = textfieldUserPassword.text?.replacingOccurrences(of: " ", with: "")
        if (tempClean1 != nil) && (tempClean2 != nil)&&(tempClean1 != "") && (tempClean2 != ""){
            showLogoutUI()
        }
        
    }
    
    @IBAction func buttonLogout(_ sender: Any) {
        showLoginUI()
    }
    
    func showLoginUI(){
        labelPassword.isHidden = false
        labelUserName.isHidden = false
        textfieldUserPassword.isHidden = false
        textfieldUserName.isHidden = false
        btnLogin.isHidden = false
        btnLogout.isHidden = true
        labelForUserNameDidLogin.isHidden = true
        isLoginStatus = "logout"
        label1.isHidden = true
    }
    
    func showLogoutUI(){
        labelPassword.isHidden = true
        labelUserName.isHidden = true
        textfieldUserPassword.isHidden = true
        textfieldUserName.isHidden = true
        btnLogin.isHidden = true
        btnLogout.isHidden = false
        labelForUserNameDidLogin.isHidden = false
        isLoginStatus = "login"
        label1.isHidden = false
    }
    
    func login(){
        let url = URL(string: "https://sheetsu.com/apis/v1.0/301105b950f0")
        var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 30)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let loginDataDictionary = ["user": textfieldUserName.text!, "password":textfieldUserPassword.text!]
        do {
            print("loginDataDictionary \(loginDataDictionary)")
            let data = try  JSONSerialization.data(withJSONObject: loginDataDictionary, options: [])
            let task = URLSession.shared.uploadTask(with: request, from: data) { (data, res, err) in
                    let str = String(data: data!, encoding: .utf8)
                    print("result \(str)")
                DispatchQueue.main.async {
                    _ = self.navigationController?.popViewController(animated: true )
                }
            }
            task.resume()
        }
        catch {
            print(error)
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
