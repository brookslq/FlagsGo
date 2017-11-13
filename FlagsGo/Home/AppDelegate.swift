//
//  AppDelegate.swift
//  FlagsGo
//
//  Created by brooks on 2017/11/9.
//  Copyright © 2017年 brooks. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        

        
        let flagsTabBarVC = FlagsTabBarViewController()
        //需要通过self. 否则运行失败
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        self.window?.rootViewController = flagsTabBarVC
        self.window?.makeKeyAndVisible()
        
        //设置启动页面停留时间
        Thread.sleep(forTimeInterval: 1.5)
        return true
    }
    
}

