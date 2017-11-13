//
//  ViewController.swift
//  FlagsGo
//
//  Created by brooks on 2017/11/9.
//  Copyright © 2017年 brooks. All rights reserved.
//

import UIKit

class FlagsTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let flagsgoVC = FlagsGoViewController()
        flagsgoVC.title = "旗扬"
        let poetryVC = PoetryViewController()
        poetryVC.title = "诗情"
        let weatherVC = WeatherViewController()
        weatherVC.title = "天气"
        let userVC = UserViewController()
        userVC.title = "我的"
        
        //声明视图控制器
        let flagsgo = UINavigationController(rootViewController: flagsgoVC)
        flagsgo.tabBarItem.image = UIImage(named: "tabbar_flag_g")
        flagsgo.tabBarItem.selectedImage = UIImage(named: "tabbar_flag_r")?.withRenderingMode(.alwaysOriginal)
        
        
        let poetry = UINavigationController(rootViewController: poetryVC)
        
        poetry.tabBarItem.image = UIImage(named: "tabbar_poetry_g")
        poetry.tabBarItem.selectedImage = UIImage(named: "tabbar_poetry_r")?.withRenderingMode(.alwaysOriginal)
        
        let weather = UINavigationController(rootViewController: weatherVC)
        
        weather.tabBarItem.image = UIImage(named: "tabbar_weather_g")
        weather.tabBarItem.selectedImage = UIImage(named: "tabbar_weather_r")?.withRenderingMode(.alwaysOriginal)
        
        let user = UINavigationController(rootViewController: userVC)
        
        user.tabBarItem.image = UIImage(named: "tabbar_user_g")
        user.tabBarItem.selectedImage = UIImage(named: "tabbar_user_r")?.withRenderingMode(.alwaysOriginal)
        
        self.viewControllers = [flagsgo, poetry, weather, user]
        
        //默认选中的是home主界面视图
        self.selectedIndex = 0
        //设置皮肤色，这样字体就统一颜色了，不用每个设置
        self.tabBar.tintColor = UIColor.black
    }


}

