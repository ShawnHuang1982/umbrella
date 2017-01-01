//
//  FavoriteStationViewController.swift
//  umbrella
//
//  Created by  shawn on 19/12/2016.
//  Copyright © 2016 shawn. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FavoriteStationViewController: UIViewController,editMyFavoriteStationDelegate {
    @IBOutlet weak var favoriteStationTableView: UITableView!
    //給cell1用的
    var routeName = ["中和新蘆線","淡水信義線","松山新店線","文湖線","板南線"]
    //給cell2,cell3用的
    var arrayStationFavoriteOrange = [String]() //橘線的favorite站
    var arrayStationFavoriteRed = [String]() //紅線的favorite站
    var arrayStationFavoriteBrown = [String]() //棕線的favorite站
    var arrayStationFavoriteGreen = [String]() //綠線的favorite站
    var arrayStationFavoriteBlue = [String]() //藍線的favorite站
    //    var routeOrangeStationName = ["OR01","OR02","OR03","OR04"]    //測試用
    //    var routeRedStationName = ["R01","R02"]   //測試用
    //    var routeGreenStationName = ["G01","G02"] //測試用
    //    var routeBrownStationName = ["BR01","BR02","BR03"]    //測試用
    //    var routeBlueStationName = ["B01","B02","B03","B04"]  //測試用
    var mrtOrangeColor = UIColor(red: 0.973, green: 0.714, blue: 0.110, alpha: 1)
    var mrtRedColor = UIColor(red: 0.890, green: 0.0, blue: 0.176, alpha: 1)
    var mrtGreenColor = UIColor(red: 0.004, green: 0.525, blue: 0.349, alpha: 1)
    var mrtBrownColor = UIColor(red: 0.765, green: 0.549, blue: 0.188, alpha: 1)
    var mrtBlueColor = UIColor(red: 0, green: 0.435, blue: 0.737, alpha: 1)
    
    var deCodeJsonStationResult = [StructStation]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate //都是同一個

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteStationTableView.dataSource = self
        favoriteStationTableView.delegate = self
        
        //     let nib1 = UINib(nibName: "CustomFavortieHeaderTableViewCell", bundle: nil)
        //    let nib2 = UINib(nibName: "CustomFavoriteContentTableViewCell", bundle: nil)
        //    let nib3 = UINib(nibName: "CustomFavoriteFooterTableViewCell", bundle: nil)
        //        favoriteStationTableView.register(nib1, forCellReuseIdentifier: "Cell1")
        //        favoriteStationTableView.register(nib2, forCellReuseIdentifier: "Cell2")
        //        favoriteStationTableView.register(nib3, forCellReuseIdentifier: "Cell3")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        requestData()
        self.favoriteStationTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    func editFavoriteStationFunc(){
    //        print("editFavoriteStationFunc")
    //    }
    
    func requestData(){
        deCodeJsonStationResult = []
        
        let urlString = "http://139.162.76.87/api/v1/stations"
        let parameter:Parameters = [
            "auth_token" : appDelegate.jsonBackToken,
            "user_id":appDelegate.jsonBackUserID
        ]
        Alamofire.request(urlString, parameters: parameter).responseJSON {
            (response) in
            switch response.result{
            case .success:
                let jsonPackage = JSON(response.result.value)
                //print("站點傘數量json資料包",jsonPackage)
                let jsonArrayAllLocation = jsonPackage["all_locations"].arrayValue
                //print("所有站點json資料包",jsonArrayAllLocation)
                for i in 0...jsonArrayAllLocation.count-1{
                    let jsonArrayLocationName = jsonArrayAllLocation[i]["location_name"].stringValue ?? ""
                    let jsonArrayLocationLat = (jsonArrayAllLocation[i]["location_coordinate"]["latitude"]).doubleValue
                    let jsonArrayLocationLon = (jsonArrayAllLocation[i]["location_coordinate"]["longitude"]).doubleValue
                    let jsonArrayLocationPlaceID = jsonArrayAllLocation[i]["location_id"].stringValue ?? ""
                    let jsonArrayLocationRoute1a = jsonArrayAllLocation[i]["mrt_line"].arrayValue
                    let jsonArrayLocationRoute1b = jsonArrayLocationRoute1a.first?["line_name"].stringValue ?? ""
                    let jsonArrayLocationUMBNumber = jsonArrayAllLocation[i]["rentable_umbrella_number"].stringValue ?? ""
                    
                    self.deCodeJsonStationResult.append(StructStation(stationPlaceID: jsonArrayLocationPlaceID , stationName: jsonArrayLocationName, stationLat: jsonArrayLocationLat, stationLon: jsonArrayLocationLon, stationUmbrellaLeftNumber: jsonArrayLocationUMBNumber, stationRoute1ID: jsonArrayLocationRoute1b, stationRoute2ID: "" , distanceFromUserToStation: 0))
                }
                
                DispatchQueue.main.async {
                    self.favoriteStationTableView.reloadData()
                }
                
                
            case .failure(let error):
                print(error)
                
            }
        }
    }

    
}

extension FavoriteStationViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return routeName.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
        //讀檔
        if let loadedArrayOrange = UserDefaults.standard.stringArray(forKey: "myFavoriteOrange"){
            arrayStationFavoriteOrange = loadedArrayOrange
            print("1.Orange arrayStationFavorite的數量",arrayStationFavoriteOrange)
        }
        if (arrayStationFavoriteOrange.count == 0) || (arrayStationFavoriteOrange == nil) {
            arrayStationFavoriteOrange = []
            print("2.Orange arrayStationFavorite的數量",arrayStationFavoriteOrange)
            return 0
        }else{
            return arrayStationFavoriteOrange.count+1
        }
        case 1:
        //讀檔
        if let loadedArrayRed = UserDefaults.standard.stringArray(forKey: "myFavoriteRed"){
            arrayStationFavoriteRed = loadedArrayRed
            print("1.Red arrayStationFavorite的數量",arrayStationFavoriteRed)
        }
        
        if (arrayStationFavoriteRed.count == 0) || (arrayStationFavoriteRed == nil) {
            arrayStationFavoriteRed = []
            print("2.Red arrayStationFavorite的數量",arrayStationFavoriteRed)
            return 0
        }else{
            return arrayStationFavoriteRed.count+1
        }
        case 2:
        //讀檔
        if let loadedArrayGreen = UserDefaults.standard.stringArray(forKey: "myFavoriteGreen"){
            arrayStationFavoriteGreen = loadedArrayGreen
            print("1.Green arrayStationFavorite的數量",arrayStationFavoriteGreen)
        }
        if (arrayStationFavoriteGreen.count == 0) || (arrayStationFavoriteGreen == nil) {
            arrayStationFavoriteGreen = []
            print("2.Green arrayStationFavorite的數量",arrayStationFavoriteGreen)
            return 0
        }else{
            return arrayStationFavoriteGreen.count+1
        }
        case 3:
        //讀檔
        if let loadedArrayBrown = UserDefaults.standard.stringArray(forKey: "myFavoriteBrown"){
            arrayStationFavoriteBrown = loadedArrayBrown
            print("1.Brwon arrayStationFavorite的數量",arrayStationFavoriteBrown)
        }
        if (arrayStationFavoriteBrown.count == 0) || (arrayStationFavoriteBrown == nil){
            arrayStationFavoriteBrown = []
            print("2.Brwon arrayStationFavorite的數量",arrayStationFavoriteBrown)
            return 0
        }else{
            return arrayStationFavoriteBrown.count+1
        }
        case 4:
        //讀檔
        if let loadedArrayBlue = UserDefaults.standard.stringArray(forKey: "myFavoriteBlue"){
            arrayStationFavoriteBlue = loadedArrayBlue
            print("1.Blue arrayStationFavorite的數量",arrayStationFavoriteBlue)
        }
        if (arrayStationFavoriteBlue.count == 0) || (arrayStationFavoriteBlue == nil){
            arrayStationFavoriteBlue = []
            print("2.Blue arrayStationFavorite的數量",arrayStationFavoriteBlue)
            return 0
        }else{
            return arrayStationFavoriteBlue.count+1
        }
        default:
        print("check error")
        return 0
    }
    return 0

        // 測試用
        //        switch section {
        //        case 0:
        //            return routeOrangeStationName.count+1
        //        case 1:
        //            return routeRedStationName.count+1
        //        case 2:
        //            return routeGreenStationName.count+1
        //        case 3:
        //            return routeBrownStationName.count+1
        //        case 4:
        //            return routeBlueStationName.count+1
        //        default:
        //            print("check error")
        //            return 0
        //        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //一般tableView設定Cell有一個
        //let cell1 = tableView.dequeueReusableCell(withIdentifier: "Cell1") as?CustomFavortieHeaderTableViewCell
        //print(cell1)
        //客制Cell要用這種方法生出來,方法1
        let cell1 = Bundle.main.loadNibNamed("CustomFavortieHeaderTableViewCell", owner: self, options: nil)?.first as! CustomFavortieHeaderTableViewCell
        let cell2 = Bundle.main.loadNibNamed("CustomFavoriteContentTableViewCell", owner: self, options: nil)?.first as! CustomFavoriteContentTableViewCell
        let cell3 = Bundle.main.loadNibNamed("CustomFavoriteFooterTableViewCell", owner: self, options: nil)?.first as! CustomFavoriteFooterTableViewCell
        
        //客制Cell要用這種方法生出來,方法2
        //            let cell1 = favoriteStationTableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as! CustomFavortieHeaderTableViewCell
        //        let cell2 = favoriteStationTableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as! CustomFavoriteContentTableViewCell
        //        let cell3 = favoriteStationTableView.dequeueReusableCell(withIdentifier: "Cell3", for: indexPath) as! CustomFavoriteFooterTableViewCell
        
        //------------------------------------------------
        cell1.delegate = self
        cell1.selectionStyle = .none
        
        //        cell1.layer.masksToBounds = false
        //   //     cell1.layer.shadowOffset = CGSize(width: 0, height: 0)
        //        cell1.layer.shadowColor = UIColor.black.cgColor
        //        cell1.layer.shadowRadius = 40
        //        cell1.layer.shadowOpacity = 3.23
        //
        //
        //        cell3.layer.masksToBounds = false
        //    //    cell3.layer.shadowOffset = CGSize(width: 0, height: 0)
        //        cell3.layer.shadowColor = UIColor.black.cgColor
        //        cell3.layer.shadowRadius = 40
        //        cell3.layer.shadowOpacity = 3.23
        
        cell2.selectionStyle = .none
        cell3.selectionStyle = .none
        
        cell2.btnFavoriteStatus.isHidden = true
        cell3.btnFavoriteStatus.isHidden = true
        
        //----------------------------------------------cell1
        if (indexPath.section == 0) && (indexPath.row == 0){
            cell1.viewInCell.backgroundColor = mrtOrangeColor
            print(routeName[0])
            cell1.labelFavoriteStation.text = routeName[0]
            return cell1
        }
        if (indexPath.section == 1) && (indexPath.row == 0){
            cell1.viewInCell.backgroundColor = mrtRedColor
            cell1.labelFavoriteStation.text = routeName[1]
            return cell1
        }
        if (indexPath.section == 2) && (indexPath.row == 0){
            cell1.viewInCell.backgroundColor = mrtGreenColor
            cell1.labelFavoriteStation.text = routeName[2]
            return cell1
        }
        if (indexPath.section == 3) && (indexPath.row == 0){
            cell1.viewInCell.backgroundColor = mrtBrownColor
            cell1.labelFavoriteStation.text = routeName[3]
            return cell1
        }
        if (indexPath.section == 4) && (indexPath.row == 0){
            cell1.viewInCell.backgroundColor = mrtBlueColor
            cell1.labelFavoriteStation.text = routeName[4]
            return cell1
        }
        //---------------------------------------------cell2
        if (indexPath.section == 0) && (indexPath.row >= 1) && ( arrayStationFavoriteOrange.count > indexPath.row ){
            print("1a")
            cell2.leftViewline.backgroundColor = mrtOrangeColor
            cell2.rightViewline.backgroundColor = mrtOrangeColor
            cell2.bottomViewline.backgroundColor = mrtOrangeColor
            cell2.labelFavoriteContentStationName.text = arrayStationFavoriteOrange[indexPath.row-1]
            cell2.labelUNBNumberLeft.text = filterUMBNumber(stationName: arrayStationFavoriteOrange[indexPath.row-1])
            return cell2
        }
        if (indexPath.section == 1) && (indexPath.row >= 1) && ( arrayStationFavoriteRed.count > indexPath.row ){
            print("2a")
            cell2.leftViewline.backgroundColor = mrtRedColor
            cell2.rightViewline.backgroundColor = mrtRedColor
            cell2.bottomViewline.backgroundColor = mrtRedColor
            cell2.labelFavoriteContentStationName.text = arrayStationFavoriteRed[indexPath.row-1]
            cell2.labelUNBNumberLeft.text = filterUMBNumber(stationName: arrayStationFavoriteRed[indexPath.row-1])
            return cell2
        }
        if (indexPath.section == 2) && (indexPath.row >= 1) && ( arrayStationFavoriteGreen.count > indexPath.row ){
            print("3a")
            cell2.leftViewline.backgroundColor = mrtGreenColor
            cell2.rightViewline.backgroundColor = mrtGreenColor
            cell2.bottomViewline.backgroundColor = mrtGreenColor
            cell2.labelFavoriteContentStationName.text = arrayStationFavoriteGreen[indexPath.row-1]
             cell2.labelUNBNumberLeft.text = filterUMBNumber(stationName: arrayStationFavoriteGreen[indexPath.row-1])
            return cell2
        }
        if (indexPath.section == 3) && (indexPath.row >= 1) && ( arrayStationFavoriteBrown.count > indexPath.row ){
            print("4a")
            cell2.leftViewline.backgroundColor = mrtBrownColor
            cell2.rightViewline.backgroundColor = mrtBrownColor
            cell2.bottomViewline.backgroundColor = mrtBrownColor
            cell2.labelFavoriteContentStationName.text = arrayStationFavoriteBrown[indexPath.row-1]
            cell2.labelUNBNumberLeft.text = filterUMBNumber(stationName: arrayStationFavoriteBrown[indexPath.row-1])
            return cell2
        }
        if (indexPath.section == 4) && (indexPath.row >= 1) && ( arrayStationFavoriteBlue.count > indexPath.row ){
            print("5a")
            cell2.leftViewline.backgroundColor = mrtBlueColor
            cell2.rightViewline.backgroundColor = mrtBlueColor
            cell2.bottomViewline.backgroundColor = mrtBlueColor
            cell2.labelFavoriteContentStationName.text = arrayStationFavoriteBlue[indexPath.row-1]
            cell2.labelUNBNumberLeft.text = filterUMBNumber(stationName: arrayStationFavoriteBlue[indexPath.row-1])

            return cell2
        }
        //----------------------------------------------cell3
        print("aa",indexPath.row)
        print("bb",arrayStationFavoriteOrange.count)
        print("cc",arrayStationFavoriteBlue.count)
        if (indexPath.section == 0) && (indexPath.row == arrayStationFavoriteOrange.count){
            print("1")
            cell3.leftViewline.backgroundColor = mrtOrangeColor
            cell3.rightViewline.backgroundColor = mrtOrangeColor
            cell3.bottomViewline.backgroundColor = mrtOrangeColor
            cell3.labelFavoriteContentStationName.text = arrayStationFavoriteOrange[indexPath.row-1]
             cell3.labelUNBNumberLeft.text = filterUMBNumber(stationName: arrayStationFavoriteOrange[indexPath.row-1])
            return cell3
        }
        if (indexPath.section == 1) && (indexPath.row == arrayStationFavoriteRed.count){
            print("2")
            cell3.leftViewline.backgroundColor = mrtRedColor
            cell3.rightViewline.backgroundColor = mrtRedColor
            cell3.bottomViewline.backgroundColor = mrtRedColor
            cell3.labelFavoriteContentStationName.text = arrayStationFavoriteRed[indexPath.row-1]
             cell3.labelUNBNumberLeft.text = filterUMBNumber(stationName: arrayStationFavoriteRed[indexPath.row-1])
            return cell3
        }
        if (indexPath.section == 2) && (indexPath.row == arrayStationFavoriteGreen.count){
            print("3")
            cell3.leftViewline.backgroundColor = mrtGreenColor
            cell3.rightViewline.backgroundColor = mrtGreenColor
            cell3.bottomViewline.backgroundColor = mrtGreenColor
            cell3.labelFavoriteContentStationName.text = arrayStationFavoriteGreen[indexPath.row-1]
            cell3.labelUNBNumberLeft.text = filterUMBNumber(stationName: arrayStationFavoriteGreen[indexPath.row-1])
            return cell3
        }
        if (indexPath.section == 3) && (indexPath.row == arrayStationFavoriteBrown.count){
            print("4")
            cell3.leftViewline.backgroundColor = mrtBrownColor
            cell3.rightViewline.backgroundColor = mrtBrownColor
            cell3.bottomViewline.backgroundColor = mrtBrownColor
            cell3.labelFavoriteContentStationName.text = arrayStationFavoriteBrown[indexPath.row-1]
            cell3.labelUNBNumberLeft.text = filterUMBNumber(stationName: arrayStationFavoriteBrown[indexPath.row-1])
            return cell3
        }
        if (indexPath.section == 4) && (indexPath.row == arrayStationFavoriteBlue.count){
            print("5")
            cell3.leftViewline.backgroundColor = mrtBlueColor
            cell3.rightViewline.backgroundColor = mrtBlueColor
            cell3.bottomViewline.backgroundColor = mrtBlueColor
            cell3.labelFavoriteContentStationName.text = arrayStationFavoriteBlue[indexPath.row-1]
            cell3.labelUNBNumberLeft.text = filterUMBNumber(stationName: arrayStationFavoriteBlue[indexPath.row-1])
            return cell3
        }
        return UITableViewCell()
    }
    //比較我的最愛的資料去取得傘的剩餘數量,並且回傳傘的數量
    func filterUMBNumber(stationName:String) -> String {
        for (index,number) in deCodeJsonStationResult.enumerated(){
            if stationName == deCodeJsonStationResult[index].stationName{
                print("是我的最愛站",deCodeJsonStationResult[index].stationUmbrellaLeftNumber)
                return deCodeJsonStationResult[index].stationUmbrellaLeftNumber
            }
        }
        print("不是我的最愛站")
            return ""
        }

    //實作Delegate的方法
    func editMyFavoriteStation() {
        print("第一版我的最愛站點增加的function,已取消")
    }
    func didFinishMyFavortieStation() {
        print("2222")
    }
    func cancelActionMyFavortieStation() {
        print("3333")
    }
    
}

extension FavoriteStationViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did")
    }
    
    //改Section顏色
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.clear
        
        //tableView.tableFooterView?.backgroundColor = UIColor.clear
    }
    //改Section大小
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0{
            return 0
        }else{
            return 20
        }
    }
    
    //改cell的高度
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        if indexPath.row == 0{
    //          return 45
    //        }
    //        return 45
    //   }
    
}

