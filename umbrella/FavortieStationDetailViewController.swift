//
//  FavortieStationDetailViewController.swift
//  umbrella
//
//  Created by  shawn on 01/01/2017.
//  Copyright © 2017 shawn. All rights reserved.
//

import UIKit

class FavortieStationDetailViewController: UIViewController {

    @IBOutlet weak var tableViewFavoriteDetail: UITableView!
    //給cell1用的
    var routeName = ["中和新蘆線","淡水信義線","松山新店線","文湖線","板南線"]
    //給cell2,cell3用的
    var arrayStationFavoriteOrange = [String]() //橘線的favorite站
    var arrayStationFavoriteRed = [String]() //紅線的favorite站
    var arrayStationFavoriteBrown = [String]() //棕線的favorite站
    var arrayStationFavoriteGreen = [String]() //綠線的favorite站
    var arrayStationFavoriteBlue = [String]() //藍線的favorite站
    //cell1~3用的
    var mrtOrangeColor = UIColor(red: 0.973, green: 0.714, blue: 0.110, alpha: 1)
    var mrtRedColor = UIColor(red: 0.890, green: 0.0, blue: 0.176, alpha: 1)
    var mrtGreenColor = UIColor(red: 0.004, green: 0.525, blue: 0.349, alpha: 1)
    var mrtBrownColor = UIColor(red: 0.765, green: 0.549, blue: 0.188, alpha: 1)
    var mrtBlueColor = UIColor(red: 0, green: 0.435, blue: 0.737, alpha: 1)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //設定navigationItem
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSFontAttributeName:UIFont(name: "PingFang TC", size: 12.0)], for: .normal)
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem?.setTitlePositionAdjustment(UIOffsetMake(0.0, 0.0), for: .default)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        //設定tableview
        tableViewFavoriteDetail.dataSource = self
        tableViewFavoriteDetail.delegate = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableViewFavoriteDetail.reloadData()
    }
    
    @IBAction func barItemBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}

extension FavortieStationDetailViewController:UITableViewDataSource,UITableViewDelegate{
    
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
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Cell設定詳見FavoriteStationViewController
        let cell1 = Bundle.main.loadNibNamed("CustomFavortieHeaderTableViewCell", owner: self, options: nil)?.first as! CustomFavortieHeaderTableViewCell
        let cell2 = Bundle.main.loadNibNamed("CustomFavoriteContentTableViewCell", owner: self, options: nil)?.first as! CustomFavoriteContentTableViewCell
        let cell3 = Bundle.main.loadNibNamed("CustomFavoriteFooterTableViewCell", owner: self, options: nil)?.first as! CustomFavoriteFooterTableViewCell

        //設定cell1~cell3點選後不會出現反灰色
        cell1.selectionStyle = .none
        cell2.selectionStyle = .none
        cell3.selectionStyle = .none
        
        //出現favorite按鈕
        cell2.btnFavoriteStatus.isHidden = false
        cell3.btnFavoriteStatus.isHidden = false
        
        //設定cell的我的最愛button被按下要處理事件的人是這個viewcontroller,代表是從我的最愛陣列刪除
        cell2.delegate = self
        cell3.delegate = self
        
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
        //我的最愛編輯時不需要顯示傘的數量
        cell2.labelUNBNumberLeft.isHidden = true
        cell2.imageIconUMB.isHidden = true
        
        //開始顯示cell2
        if (indexPath.section == 0) && (indexPath.row >= 1) && ( arrayStationFavoriteOrange.count > indexPath.row ){
            print("section0-cell2")
            cell2.leftViewline.backgroundColor = mrtOrangeColor
            cell2.rightViewline.backgroundColor = mrtOrangeColor
            cell2.bottomViewline.backgroundColor = mrtOrangeColor
            cell2.labelFavoriteContentStationName.text = arrayStationFavoriteOrange[indexPath.row-1]
            return cell2
        }
        if (indexPath.section == 1) && (indexPath.row >= 1) && ( arrayStationFavoriteRed.count > indexPath.row ){
            print("section1-cell2")
            cell2.leftViewline.backgroundColor = mrtRedColor
            cell2.rightViewline.backgroundColor = mrtRedColor
            cell2.bottomViewline.backgroundColor = mrtRedColor
            cell2.labelFavoriteContentStationName.text = arrayStationFavoriteRed[indexPath.row-1]
            return cell2
        }
        if (indexPath.section == 2) && (indexPath.row >= 1) && ( arrayStationFavoriteGreen.count > indexPath.row ){
            print("section2-cell2")
            cell2.leftViewline.backgroundColor = mrtGreenColor
            cell2.rightViewline.backgroundColor = mrtGreenColor
            cell2.bottomViewline.backgroundColor = mrtGreenColor
            cell2.labelFavoriteContentStationName.text = arrayStationFavoriteGreen[indexPath.row-1]
            return cell2
        }
        if (indexPath.section == 3) && (indexPath.row >= 1) && ( arrayStationFavoriteBrown.count > indexPath.row ){
            print("section3-cell2")
            cell2.leftViewline.backgroundColor = mrtBrownColor
            cell2.rightViewline.backgroundColor = mrtBrownColor
            cell2.bottomViewline.backgroundColor = mrtBrownColor
            cell2.labelFavoriteContentStationName.text = arrayStationFavoriteBrown[indexPath.row-1]
            return cell2
        }
        if (indexPath.section == 4) && (indexPath.row >= 1) && ( arrayStationFavoriteBlue.count > indexPath.row ){
            print("section4-cell2")
            cell2.leftViewline.backgroundColor = mrtBlueColor
            cell2.rightViewline.backgroundColor = mrtBlueColor
            cell2.bottomViewline.backgroundColor = mrtBlueColor
            cell2.labelFavoriteContentStationName.text = arrayStationFavoriteBlue[indexPath.row-1]
            return cell2
        }
        //----------------------------------------------cell3
        //我的最愛編輯時不需要顯示傘的數量
        cell3.labelUNBNumberLeft.isHidden = true
        cell3.imageIconUMB.isHidden = true
        
        //開始顯示cell3
        print("cell3產生第\(indexPath.row)列")
        //        print("bb",routeOrangeStationName.count)
        //        print("cc",routeBlueStationName.count)
        if (indexPath.section == 0) && (indexPath.row == arrayStationFavoriteOrange.count){
            print("section0-cell3")
            cell3.leftViewline.backgroundColor = mrtOrangeColor
            cell3.rightViewline.backgroundColor = mrtOrangeColor
            cell3.bottomViewline.backgroundColor = mrtOrangeColor
            cell3.labelFavoriteContentStationName.text =   arrayStationFavoriteOrange[indexPath.row-1]
            return cell3
        }
        if (indexPath.section == 1) && (indexPath.row == arrayStationFavoriteRed.count){
            print("section1-cell3")
            cell3.leftViewline.backgroundColor = mrtRedColor
            cell3.rightViewline.backgroundColor = mrtRedColor
            cell3.bottomViewline.backgroundColor = mrtRedColor
            cell3.labelFavoriteContentStationName.text = arrayStationFavoriteRed[indexPath.row-1]
            return cell3
        }
        if (indexPath.section == 2) && (indexPath.row == arrayStationFavoriteGreen.count){
            print("section2-cell3")
            cell3.leftViewline.backgroundColor = mrtGreenColor
            cell3.rightViewline.backgroundColor = mrtGreenColor
            cell3.bottomViewline.backgroundColor = mrtGreenColor
            cell3.labelFavoriteContentStationName.text = arrayStationFavoriteGreen[indexPath.row-1]
            return cell3
        }
        if (indexPath.section == 3) && (indexPath.row == arrayStationFavoriteBrown.count){
            print("section3-cell3")
            cell3.leftViewline.backgroundColor = mrtBrownColor
            cell3.rightViewline.backgroundColor = mrtBrownColor
            cell3.bottomViewline.backgroundColor = mrtBrownColor
            cell3.labelFavoriteContentStationName.text = arrayStationFavoriteBrown[indexPath.row-1]
            return cell3
        }
        if (indexPath.section == 4) && (indexPath.row == arrayStationFavoriteBlue.count){
            print("section4-cell3")
            cell3.leftViewline.backgroundColor = mrtBlueColor
            cell3.rightViewline.backgroundColor = mrtBlueColor
            cell3.bottomViewline.backgroundColor = mrtBlueColor
            cell3.labelFavoriteContentStationName.text = arrayStationFavoriteBlue[indexPath.row-1]
            return cell3
        }
        return UITableViewCell()
    }
    
    //改Section顏色
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.clear
    }
    
    //改Section大小
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0
        }else{
            return 20
        }
    }
    
}

extension FavortieStationDetailViewController:cancelFavoriteCell2Delegate,cancelFavoriteCell3Delegate{
    
    func removeThisStationAtFavoriteCell2(cell: CustomFavoriteContentTableViewCell) {
        let indexPathRow = self.tableViewFavoriteDetail.indexPathForRow(at: cell.center)?.row
        let indexPathSection = self.tableViewFavoriteDetail.indexPathForRow(at: cell.center)?.section
        print("點選的row=\(indexPathRow),\(indexPathSection)")
        
        removeInArray(indexPathRow: indexPathRow!, indexPathSection: indexPathSection!)
        
        self.tableViewFavoriteDetail.reloadData()
    }
    
    func removeThisStationAtFavoriteCell3(cell: CustomFavoriteFooterTableViewCell) {
        let indexPathRow = self.tableViewFavoriteDetail.indexPathForRow(at: cell.center)?.row
        let indexPathSection = self.tableViewFavoriteDetail.indexPathForRow(at: cell.center)?.section
        print("點選的row=\(indexPathRow),\(indexPathSection)")
        
        removeInArray(indexPathRow: indexPathRow!, indexPathSection: indexPathSection!)
        
        self.tableViewFavoriteDetail.reloadData()
    }
    
    
    func removeInArray(indexPathRow:Int,indexPathSection:Int){
        switch indexPathSection {
        case 0:
            print("orange陣列移除")
                arrayStationFavoriteOrange.remove(at: (indexPathRow-1))
            //存檔
            UserDefaults.standard.set(self.arrayStationFavoriteOrange, forKey: "myFavoriteOrange")
            //同步
            UserDefaults.standard.synchronize()
        case 1:
        print("red陣列移除")
            arrayStationFavoriteRed.remove(at: (indexPathRow-1))
            //存檔
            UserDefaults.standard.set(self.arrayStationFavoriteRed, forKey: "myFavoriteRed")
            //同步
            UserDefaults.standard.synchronize()
        case 2:
         print("green陣列移除")
            arrayStationFavoriteGreen.remove(at: (indexPathRow-1))
             //存檔
            UserDefaults.standard.set(self.arrayStationFavoriteGreen, forKey: "myFavoriteGreen")
             //同步
             UserDefaults.standard.synchronize()
        case 3:
            print("Brown陣列移除")
            arrayStationFavoriteBrown.remove(at: (indexPathRow-1))
            //存檔
            UserDefaults.standard.set(self.arrayStationFavoriteBrown, forKey: "myFavoriteBrown")
            //同步
            UserDefaults.standard.synchronize()

        case 4:
            print("Blue陣列移除")
            arrayStationFavoriteBlue.remove(at: (indexPathRow-1))
            //存檔
            UserDefaults.standard.set(self.arrayStationFavoriteBlue, forKey: "myFavoriteBlue")
            //同步
            UserDefaults.standard.synchronize()
        default:
        print("error in cell3 button")
        }
        //self.tableViewFavoriteDetail.reloadData()
    }

}
