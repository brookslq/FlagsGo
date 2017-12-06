//
//  AppDelegate.swift
//  FlagsGo
//
//  Created by brooks on 2017/11/9.
//  Copyright © 2017年 brooks. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

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
        
        //申请本地通知的权限
        //ios10 及以上版本
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) {
                (accepted, error) in
                if !accepted {
                    print("用户不允许消息通知")
                }
        }
        //允许通知在前台状态下也可以显示
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    
    
    // 清除通知栏和角标
    func applicationWillEnterForeground(application: UIApplication) {
        application.applicationIconBadgeNumber = 0
    }
    
    
    //从后台点击icon进入时清除角标
    func applicationWillEnterForeground(_ application: UIApplication) {
        let num = application.applicationIconBadgeNumber
        if num != 0 {
            application.applicationIconBadgeNumber = 0
        }
    }
    
    
    //MARK: - 前台时可以显示
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .sound, .alert])
    }
    
}


