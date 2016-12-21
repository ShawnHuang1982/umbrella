//
//  ViewController.swift
//  umbrella
//
//  Created by  shawn on 15/12/2016.
//  Copyright © 2016 shawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func buttonPopToFirstVC(_ sender: Any) {
        // pop controller 到 某個viewcontroller
            //方法1
            //            _ = navigationController?.popToViewController((self.navigationController?.viewControllers[0] as! SettingTableViewController), animated: true)
            //方法2
            //            for i in (navigationController?.viewControllers)!{
            //                if i is SettingTableViewController{
            //                    _ = navigationController?.popToViewController((i as! SettingTableViewController), animated: true)
            //                    }
            //            }
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //test
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

