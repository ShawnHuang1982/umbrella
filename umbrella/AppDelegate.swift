//
//  AppDelegate.swift
//  umbrella
//
//  Created by  shawn on 15/12/2016.
//  Copyright © 2016 shawn. All rights reserved.
//

import UIKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let statusColorLabel = UILabel()
    var jsonBackUserID = ""
    var jsonBackToken = ""
    var jsonCanRent = false
    var jsonCanRentReady = "NotReady"
    var userNameDidLogin = ""
     var googleAPIKeyForIOS = "" //sercurity
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //提供APIKey才能使用google map service
        GMSServices.provideAPIKey(googleAPIKeyForIOS)
        
        //更改status bar的color
            //須先在info.plist裡面 新增View controller-based status bar appearance 設定為YES
        UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: true)
        statusColorLabel.frame = CGRect(x: 0, y: 0, width: (self.window?.frame.size.width)!, height: 20)
        statusColorLabel.backgroundColor = UIColor(red: 0.624, green: 0.839, blue: 0.870, alpha: 1)
        self.window?.rootViewController?.view.addSubview(statusColorLabel)
        
        return true
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

