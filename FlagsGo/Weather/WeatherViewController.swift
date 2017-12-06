//
//  WeatherViewController.swift
//  FlagsGo
//
//  Created by brooks on 2017/11/13.
//  Copyright © 2017年 brooks. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation

class WeatherViewController: UIViewController{
    let locationManager: CLLocationManager = CLLocationManager()
    var mainWeatherV: MainWeatherView!
    var refreshBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        NetProcess().postCurrentWeatherData(target: mainWeatherV, longitude: FlagTag.LONGITUDE, latitude: FlagTag.LAITUDE)
        NetProcess().postForecastWeatherData(target: mainWeatherV, longitude: FlagTag.LONGITUDE, latitude: FlagTag.LAITUDE)
       
    }

    @objc func refreshClick() {
        setLocation()
        NetProcess().postCurrentWeatherData(target: mainWeatherV, longitude: FlagTag.LONGITUDE, latitude: FlagTag.LAITUDE)
        NetProcess().postForecastWeatherData(target: mainWeatherV, longitude: FlagTag.LONGITUDE, latitude: FlagTag.LAITUDE)
        noticeTop("刷新成功", autoClear: true, autoClearTime: 1)
        title = "天气" + "·" + FlagTag.CITY
    }
    
    func setupUI() {
        title = "天气" + "·" + FlagTag.CITY
        view.backgroundColor = UIColor.initColor(r: 240, g: 240, b: 240, a: 0.8)
        
        self.navigationController?.navigationBar.tintColor = UIColor.black
        refreshBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        refreshBtn.addTarget(self, action: #selector(refreshClick), for: UIControlEvents.touchUpInside)
        refreshBtn.setImage(UIImage(named: "refresh_nor"), for: .normal)
        refreshBtn.setImage(UIImage(named: "refresh_sel"), for: .highlighted)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: refreshBtn)
        
        
        mainWeatherV = MainWeatherView(frame: CGRect(x: 0, y: 64, width: view.width, height: view.height - 108))
        view.addSubview(mainWeatherV)
        
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
                longitude = "-120"
                latitude = "36"
            }
            
            FlagTag.LONGITUDE = longitude!
            FlagTag.LAITUDE = latitude!
            DataCenter().reverseGeocode(latitude: Double(latitude!)!, longitude: Double(longitude!)!)
        }
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    
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

