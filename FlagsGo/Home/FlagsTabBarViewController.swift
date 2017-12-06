//
//  ViewController.swift
//  FlagsGo
//
//  Created by brooks on 2017/11/9.
//  Copyright © 2017年 brooks. All rights reserved.
//

import UIKit
import CoreLocation

class FlagsTabBarViewController: UITabBarController {

    let locationManager: CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTarBarUI()
        setLocation()
    }

    
    func setupTarBarUI() {
        
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
        self.selectedIndex = 1
        //设置皮肤色，这样字体就统一颜色了，不用每个设置
        self.tabBar.tintColor = UIColor.black
    }
    
    //MARK: - LOCATION
    func setLocation() {
        //设置定位服务管理器代理
        locationManager.delegate = self
        //设置定位进度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //更新距离
        locationManager.distanceFilter = 100
        ////发送授权申请
        locationManager.requestAlwaysAuthorization()
        if (CLLocationManager.locationServicesEnabled())
        {
            //允许使用定位服务的话，开启定位服务更新
            locationManager.startUpdatingLocation()
            print("定位开始")
            
            // 获取经纬度
            var longitude = locationManager.location?.coordinate.longitude.description
            var latitude = locationManager.location?.coordinate.latitude.description
            
            //如果出现nil的情况，赋默认值，防止程序奔溃
            if longitude == nil || latitude == nil {
                longitude = "120"
                latitude = "36"
            }
            
            FlagTag.LONGITUDE = longitude!
            FlagTag.LAITUDE = latitude!
            DataCenter().reverseGeocode(latitude: Double(latitude!)!, longitude: Double(longitude!)!)
        }
    }
    
}

extension FlagsTabBarViewController: CLLocationManagerDelegate {

    //定位改变执行，可以得到新位置、旧位置
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //获取最新的坐标
        let currLocation:CLLocation = locations.last!
        FlagTag.LONGITUDE = currLocation.coordinate.longitude.description
        FlagTag.LAITUDE = currLocation.coordinate.latitude.description

        //                print("经度：\(currLocation.coordinate.longitude)")
        //获取纬度
        //        print("纬度：\(currLocation.coordinate.latitude)")

    }
}

