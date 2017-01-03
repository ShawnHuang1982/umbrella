//
//  ReturnHistoryViewController.swift
//  umbrella
//
//  Created by  shawn on 20/12/2016.
//  Copyright © 2016 shawn. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ReturnHistoryViewController: UIViewController {

    @IBOutlet weak var tableViewRentHistory: UITableView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate //都是同一個
   // var arrayRentHistory = ["aa","bb","cc"] //測試用
    
    @IBOutlet weak var labelForErrorMessage: UILabel!
    var deJsonArrayRentHistory = [StructRentHistory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewRentHistory.dataSource = self
        tableViewRentHistory.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        requestData()
    }
    
    func requestData(){
        deJsonArrayRentHistory = []
        
        let urlString = "http://139.162.76.87/api/v1/user/[:id]/show_history"
        let parameter:Parameters = [
            "auth_token" : appDelegate.jsonBackToken,
            "user_id":appDelegate.jsonBackUserID
//            "auth_token" : "A8ApqyK4UBkrLKkfC9iD",
//            "user_id": "2"
        ]
        Alamofire.request(urlString, parameters: parameter).responseJSON {
            (response) in
            switch response.result{
            case .success:
                let jsonPackage = JSON(response.result.value)
                //print("租借傘紀錄的json資料包",jsonPackage)
                if jsonPackage["error"] != nil{
                    print("錯誤紀錄",jsonPackage["error"])
                    self.labelForErrorMessage.isHidden = false
                }else{
                    print("成功抓到資料")
                   self.labelForErrorMessage.isHidden = true
                    let userHistoryArray = jsonPackage["user_rent_history"].arrayValue
                    print(userHistoryArray.count)
                    
                    for (index,number) in userHistoryArray.enumerated(){
                    //資料取得
                    let a = userHistoryArray[index]["rent_duration_in_hr"].stringValue
                    let b = userHistoryArray[index]["charged_amount"].stringValue
                    let c = userHistoryArray[index]["start"]["location"]["name"].stringValue
                    let d = userHistoryArray[index]["end"]["location"]["name"]
                    let e = "\(c)-\(d)"
                    let f = userHistoryArray[index]["start"]["at_time"].stringValue
                     //資料轉型
                    var dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    let date = dateFormatter.date(from: f)
                    dateFormatter.dateFormat = "yyyy/MM/dd"
                    let dateShort = dateFormatter.string(from: date!)
                    //資料儲存
                self.deJsonArrayRentHistory.append( StructRentHistory(day: a, money: b, date: dateShort, route: e))
                
//                    print(a)
//                    print(b)
//                    print(c)
//                    print(d)
//                    print(e)
//                    print(dateShort)
//                    print(f)
//                    print("-----")
                    }
                }
                
                DispatchQueue.main.async {
                    self.tableViewRentHistory.reloadData()
                }
                
                
            case .failure(let error):
                print(error)
                
            }
        }
     //last
    }
    
//last
}

extension ReturnHistoryViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if deJsonArrayRentHistory.count == 0{
            return 0
        }else{
            return deJsonArrayRentHistory.count+1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1 = Bundle.main.loadNibNamed("CustomHistoryHeaderTableViewCell", owner: self, options: nil)?.first as! CustomHistoryHeaderTableViewCell
        let cell2 = Bundle.main.loadNibNamed("CustomHistoryContentTableViewCell", owner: self, options: nil)?.first as! CustomHistoryContentTableViewCell
        let cell3 = Bundle.main.loadNibNamed("CustomHistoryFooterTableViewCell", owner: self, options: nil)?.first as! CustomHistoryFooterTableViewCell
    
        cell1.selectionStyle = .none
        cell2.selectionStyle = .none
        cell3.selectionStyle = .none
        
        //第一欄
        if (indexPath.section == 0) && (indexPath.row == 0){
            print("第一欄")
            return cell1
        }
        //第二欄
        if (indexPath.section == 0) && (0<indexPath.row) && (indexPath.row < deJsonArrayRentHistory.count){
             print("第二欄")
            cell2.labelRentDate.text = deJsonArrayRentHistory[indexPath.row-1].date
            cell2.labelRentDay.text = deJsonArrayRentHistory[indexPath.row-1].day
            cell2.labelRentMoney.text = deJsonArrayRentHistory[indexPath.row-1].money
            cell2.labelStartToEndStation.text = deJsonArrayRentHistory[indexPath.row-1].route

            return cell2
        }
        //第三欄
        if (indexPath.section == 0) && (0<indexPath.row) && (indexPath.row == deJsonArrayRentHistory.count){
             print("第三欄")
            cell3.labelRentDate.text = deJsonArrayRentHistory[indexPath.row-1].date
            cell3.labelRentDay.text = deJsonArrayRentHistory[indexPath.row-1].day
            cell3.labelRentMoney.text = deJsonArrayRentHistory[indexPath.row-1].money
            cell3.labelStartToEndStation.text = deJsonArrayRentHistory[indexPath.row-1].route
            return cell3
        }
        
        return UITableViewCell()
    //last
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 35
        }else if indexPath.row == deJsonArrayRentHistory.count{
            return 32
        }else{
            return 30
        }
    }
    
    
    
    
//last
}
