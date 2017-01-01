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
    
    var arrayStationFavorite = [""] //哪些站是favorite
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //讀取檔案
        if let loadedArray = UserDefaults.standard.stringArray(forKey: "myFavorite"){
            arrayStationFavorite = loadedArray
        }
        
        //設定navigationItem
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSFontAttributeName:UIFont(name: "PingFang TC", size: 12.0)], for: .normal)
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem?.setTitlePositionAdjustment(UIOffsetMake(0.0, 0.0), for: .default)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        //設定tableview
        //tableViewFavoriteDetail.dataSource = self
        //tableViewFavoriteDetail.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func barItemBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}

//extension FavortieStationDetailViewController:UITableViewDataSource,UITableViewDelegate{
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return cell
//    }
//    
//}
