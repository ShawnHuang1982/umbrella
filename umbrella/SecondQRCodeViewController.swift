//
//  SecondQRCodeViewController.swift
//  umbrella
//
//  Created by mac on 2016/12/17.
//  Copyright © 2016年 shawn. All rights reserved.
//

import UIKit
protocol SecondQRCodeViewControllerDelegate{
func dismissView()
}
class SecondQRCodeViewController: UIViewController {
    var delegate:SecondQRCodeViewControllerDelegate? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

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
