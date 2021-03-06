//
//  SettingTableViewController.swift
//  umbrella
//
//  Created by mac on 2016/12/17.
//  Copyright © 2016年 shawn. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController {
    var whoSend = ""
    var whiteView = UIView()
    @IBOutlet var tableviewSettingPage: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        print("在Setting的viewWillAppear")
        print("1.whosend-->",whoSend)
        if whoSend == "QRCodeScanner"{
            tableviewSettingPage.isHidden = true
            //當用UITableViewController,其實是NavigationContrller + TableView
            self.navigationController?.view.backgroundColor = UIColor.white
            whoSend = ""
             print("2.whosend-->",whoSend)
        }else{
            tableviewSettingPage.isHidden = false
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("在Setting的ViewDidDisappear")
       
        //tableviewSettingPage.isHidden = false //會有bug
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("在Setting的viewWillDisappear")
        if whoSend == "QRCodeScanner"{
            whoSend = ""
            print("4.whosend-->",whoSend)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
          print("在Setting的viewDidAppear")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
          print("在Setting的viewDidLoad")
        self.tabBarController?.delegate = self
         print("settingViewController位置",self)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    

//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        
//        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 20))
//        //設定header背景顏色
//        //        headerView.backgroundColor = .lightGray
//        headerView.backgroundColor = UIColor(red: 0.953, green: 0.957, blue: 0.961, alpha: 1)
//        return headerView
//    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
//        if section == 0{
//        return 0
//        }else{
//            return 20
//        }
        return 30
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
/*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
*/
/*
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
*/
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SettingTableViewController:UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("In SettingTable didselect tabbar")
        whoSend = ""
        tableviewSettingPage.isHidden = false
    }
}


