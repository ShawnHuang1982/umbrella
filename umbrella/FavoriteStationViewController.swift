//
//  FavoriteStationViewController.swift
//  umbrella
//
//  Created by  shawn on 19/12/2016.
//  Copyright © 2016 shawn. All rights reserved.
//

import UIKit

class FavoriteStationViewController: UIViewController {
    @IBOutlet weak var favoriteStationTableView: UITableView!
    var routeName = ["中和新蘆線","淡水信義線","松山新店線","文湖線","板南線"]
    var routeOrangeStationName = ["OR01","OR02","OR03","OR04"]
    var routeRedStationName = ["R01","R02"]
    var routeGreenStationName = ["G01","G02"]
    var routeBrownStationName = ["BR01","BR02","BR03"]
    var routeBlueStationName = ["B01","B02","B03","B04"]
    var mrtOrangeColor = UIColor(red: 0.973, green: 0.714, blue: 0.110, alpha: 1)
    var mrtRedColor = UIColor(red: 0.890, green: 0.0, blue: 0.176, alpha: 1)
    var mrtGreenColor = UIColor(red: 0.004, green: 0.525, blue: 0.349, alpha: 1)
    var mrtBrownColor = UIColor(red: 0.765, green: 0.549, blue: 0.188, alpha: 1)
    var mrtBlueColor = UIColor(red: 0, green: 0.435, blue: 0.737, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteStationTableView.dataSource = self
        favoriteStationTableView.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension FavoriteStationViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return routeName.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return routeOrangeStationName.count+1
        case 1:
            return routeRedStationName.count+1
        case 2:
            return routeGreenStationName.count+1
        case 3:
            return routeBrownStationName.count+1
        case 4:
            return routeBlueStationName.count+1
        default:
            print("check error")
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //一般tableView設定Cell有一個
        //let cell1 = tableView.dequeueReusableCell(withIdentifier: "Cell1") as?CustomFavortieHeaderTableViewCell
        //print(cell1)
        //客制Cell要用這種方法生出來
        let cell1 = Bundle.main.loadNibNamed("CustomFavortieHeaderTableViewCell", owner: self, options: nil)?.first as! CustomFavortieHeaderTableViewCell
        let cell2 = Bundle.main.loadNibNamed("CustomFavoriteContentTableViewCell", owner: self, options: nil)?.first as! CustomFavoriteContentTableViewCell
         let cell3 = Bundle.main.loadNibNamed("CustomFavoriteFooterTableViewCell", owner: self, options: nil)?.first as! CustomFavoriteFooterTableViewCell
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
        if (indexPath.section == 0) && (indexPath.row >= 1) && ( routeOrangeStationName.count > indexPath.row ){
            print("1a")
            cell2.leftViewline.backgroundColor = mrtOrangeColor
            cell2.rightViewline.backgroundColor = mrtOrangeColor
            cell2.bottomViewline.backgroundColor = mrtOrangeColor
            cell2.labelFavoriteContentStationName.text = routeOrangeStationName[indexPath.row-1]
            return cell2
        }
          if (indexPath.section == 1) && (indexPath.row >= 1) && ( routeRedStationName.count > indexPath.row ){
            print("2a")
            cell2.leftViewline.backgroundColor = mrtRedColor
            cell2.rightViewline.backgroundColor = mrtRedColor
            cell2.bottomViewline.backgroundColor = mrtRedColor
            cell2.labelFavoriteContentStationName.text = routeRedStationName[indexPath.row-1]
            return cell2
        }
         if (indexPath.section == 2) && (indexPath.row >= 1) && ( routeGreenStationName.count > indexPath.row ){
            print("3a")
            cell2.leftViewline.backgroundColor = mrtGreenColor
            cell2.rightViewline.backgroundColor = mrtGreenColor
            cell2.bottomViewline.backgroundColor = mrtGreenColor
            cell2.labelFavoriteContentStationName.text = routeGreenStationName[indexPath.row-1]
            return cell2
        }
          if (indexPath.section == 3) && (indexPath.row >= 1) && ( routeBrownStationName.count > indexPath.row ){
            print("4a")
            cell2.leftViewline.backgroundColor = mrtBrownColor
            cell2.rightViewline.backgroundColor = mrtBrownColor
            cell2.bottomViewline.backgroundColor = mrtBrownColor
            cell2.labelFavoriteContentStationName.text = routeBrownStationName[indexPath.row-1]
            return cell2
        }
         if (indexPath.section == 4) && (indexPath.row >= 1) && ( routeBlueStationName.count > indexPath.row ){
            print("5a")
            cell2.leftViewline.backgroundColor = mrtBlueColor
            cell2.rightViewline.backgroundColor = mrtBlueColor
            cell2.bottomViewline.backgroundColor = mrtBlueColor
            cell2.labelFavoriteContentStationName.text = routeBlueStationName[indexPath.row-1]
            return cell2
        }
        //----------------------------------------------cell3
        print("aa",indexPath.row)
        print("bb",routeOrangeStationName.count)
        print("cc",routeBlueStationName.count)
        if (indexPath.section == 0) && (indexPath.row == routeOrangeStationName.count){
            print("1")
            cell3.leftViewline.backgroundColor = mrtOrangeColor
            cell3.rightViewline.backgroundColor = mrtOrangeColor
            cell3.bottomViewline.backgroundColor = mrtOrangeColor
            cell3.labelFavoriteContentStationName.text = routeOrangeStationName[indexPath.row-1]
            return cell3
        }
        if (indexPath.section == 1) && (indexPath.row == routeRedStationName.count){
             print("2")
            cell3.leftViewline.backgroundColor = mrtRedColor
            cell3.rightViewline.backgroundColor = mrtRedColor
            cell3.bottomViewline.backgroundColor = mrtRedColor
            cell3.labelFavoriteContentStationName.text = routeRedStationName[indexPath.row-1]
           return cell3
        }
        if (indexPath.section == 2) && (indexPath.row == routeGreenStationName.count){
             print("3")
            cell3.leftViewline.backgroundColor = mrtGreenColor
            cell3.rightViewline.backgroundColor = mrtGreenColor
            cell3.bottomViewline.backgroundColor = mrtGreenColor
            cell3.labelFavoriteContentStationName.text = routeGreenStationName[indexPath.row-1]
            return cell3
        }
        if (indexPath.section == 3) && (indexPath.row == routeBrownStationName.count){
             print("4")
            cell3.leftViewline.backgroundColor = mrtBrownColor
            cell3.rightViewline.backgroundColor = mrtBrownColor
            cell3.bottomViewline.backgroundColor = mrtBrownColor
            cell3.labelFavoriteContentStationName.text = routeBrownStationName[indexPath.row-1]
            return cell3
        }
        if (indexPath.section == 4) && (indexPath.row == routeBlueStationName.count){
             print("5")
            cell3.leftViewline.backgroundColor = mrtBlueColor
            cell3.rightViewline.backgroundColor = mrtBlueColor
            cell3.bottomViewline.backgroundColor = mrtBlueColor
            cell3.labelFavoriteContentStationName.text = routeBlueStationName[indexPath.row-1]
            return cell3
        }
        
        
        
        return UITableViewCell()
    }
    

}

extension FavoriteStationViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did")
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0
        }else{
            return 20
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

