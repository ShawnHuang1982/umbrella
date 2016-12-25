//
//  LoginOutViewController.swift
//  umbrella
//
//  Created by  shawn on 20/12/2016.
//  Copyright © 2016 shawn. All rights reserved.
//

import UIKit

class LoginOutViewController: UIViewController {
    @IBOutlet weak var labelErrorMessage: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var labelPassword: UILabel!
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var textfieldUserPassword: UITextField!
    @IBOutlet weak var textfieldUserName: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var labelForUserNameDidLogin: UILabel!

    var isLoginStatus = "logout"
    var whoSend = ""

    var loginJson = [String:Any]()
    var loginStatus = ""
    var loginAuthToken = ""
    var loginUserID = ""
    let appDelegate = UIApplication.shared.delegate as! AppDelegate //都是同一個
    
    override func viewDidDisappear(_ animated: Bool) {
        print("LoginViewDidDisappear")
        self.navigationController?.popViewController(animated: false)
    }
    
    //解bug,防呆,當使用者點選掃描租傘,在點選管理設定會出現被隱藏的SettingTableViewController
    override func viewWillDisappear(_ animated: Bool) {
         print("LoginViewWillDisappear")
         _ = (self.navigationController?.topViewController as? SettingTableViewController)?.whoSend = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("自己是",self)
        if (appDelegate.jsonBackToken != "") &&  (appDelegate.jsonBackUserID != ""){
            labelForUserNameDidLogin.text = appDelegate.userNameDidLogin
            isLoginStatus = "Login"
            print("登入狀態1")
        }else{
            isLoginStatus = "Logout"
            print("登出狀態2")
        }
        if  isLoginStatus == "Login"{
            showLogoutUI()
        }else{
            showLoginUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("isLoginStatus--->",isLoginStatus)
        print("token-->>",appDelegate.jsonBackToken)
        print("UserID-->>",appDelegate.jsonBackUserID)
        print("appDelegate---->>",appDelegate)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonLogin(_ sender: Any) {
        let tempClean1 = (textfieldUserName.text)?.replacingOccurrences(of: " ", with: "")
        let tempClean2 = textfieldUserPassword.text?.replacingOccurrences(of: " ", with: "")
        if (tempClean1 != nil) && (tempClean2 != nil)&&(tempClean1 != "") && (tempClean2 != ""){
            login()
            //let result = login()
            //print("回傳結果:",result)
        }
    }
    
    @IBAction func buttonLogout(_ sender: Any) {
        showLoginUI()
    }
    
    func showLoginUI(){
        appDelegate.jsonBackUserID = ""
        appDelegate.jsonBackToken = ""
        appDelegate.userNameDidLogin = ""
        labelErrorMessage.isHidden = true
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
         labelErrorMessage.isHidden = true
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
    
    func login() {//-> [String:Any] {
        let url = URL(string: "http://139.162.76.87/api/v1/login")
        var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 30)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let loginDataDictionary = ["email": textfieldUserName.text!, "password":textfieldUserPassword.text!]
        do {
            print("loginDataDictionary \(loginDataDictionary)")
            let data = try  JSONSerialization.data(withJSONObject: loginDataDictionary, options: [])
            let task = URLSession.shared.uploadTask(with: request, from: data) { (data, res, err) in
                //防止沒網路會crsh
                if err == nil{
                let str = String(data: data!, encoding: .utf8)
                    print("result \(str)")
                do{
                    try? self.loginJson = JSONSerialization.jsonObject(with: data!) as! [String : Any]
                    print("json資料包",self.loginJson)
                    let a =  "\((self.loginJson["message"])!)" ?? ""
                    if a == "Ok" {
                    self.appDelegate.jsonBackToken = "\(self.loginJson["auth_token"]!)"  ?? ""
                   self.appDelegate.jsonBackUserID = "\(self.loginJson["user_id"]!)"  ?? ""
                 self.appDelegate.userNameDidLogin = self.textfieldUserName.text! ?? ""
                    print("a=",a)
                    print("b=",self.appDelegate.jsonBackToken)
                    print("c=",self.appDelegate.jsonBackUserID)
                    if "\(a)" == "Ok" {
                        print("登入成功")
                        DispatchQueue.main.async {
                            self.labelForUserNameDidLogin.text = "歡迎\((loginDataDictionary["email"])!)"
                            self.showLogoutUI()
                            self.textfieldUserName.text = ""
                            self.textfieldUserPassword.text = ""
                            if self.whoSend == "QRCodePage"{
                                print("切換回去")
                                self.whoSend = "" //清空
                            self.navigationController?.popViewController(animated: true)
                            self.tabBarController?.selectedIndex = 2
                            //self.dismiss(animated: true, completion: nil) //ok
                                //                    return self.loginJson
                                }
                            }
                        }
                    }else{
                        DispatchQueue.main.async {
                            //登入失敗,顯示輸入錯誤的label
                            self.labelErrorMessage.isHidden = false
                        }
                    }
                }catch{
                    print("err-->",err)
                }
                }else{
                  print("err-->",err)
                }
                
            }
            task.resume()
        }
        catch {
            print("error-->",error)
        }
//        return ["":""]
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


