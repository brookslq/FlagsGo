//
//  DataCenter.swift
//  FlagsGo
//
//  Created by brooks on 2017/12/4.
//  Copyright © 2017年 brooks. All rights reserved.
//

import Foundation
import UserNotifications
import CoreLocation

class DataCenter: Any {
    
    let locationManager: CLLocationManager = CLLocationManager()
    
    
    //不能直接通过url添加一个文件夹
    
    ///归档
    func saveData(path: String, data: Any){
        let savePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString).appendingPathComponent("\(path).plist")
        NSKeyedArchiver.archiveRootObject(data, toFile: savePath)
    }
    
    ///读档
    func readData(path: String) -> Any?{
        let readPath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString).appendingPathComponent("\(path).plist")
        let data = NSKeyedUnarchiver.unarchiveObject(withFile: readPath)
        guard data != nil else {
            return nil
        }
        return data
    }
    
    ///删档
    func deleteData(path: String) {
        let deletePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString).appendingPathComponent("data/\(path).plist")
        try? FileManager.default.removeItem(atPath: deletePath)
    }
    
    
    ///构建存储路径
    func buildDataPath() -> String {
        
        let title = FlagTag.POEM_DATA.title!
        let info = FlagTag.POEM_DATA.info!
        let content = FlagTag.POEM_DATA.content.mySubString(to: 2)
        let path = content + title + "_" + info
        
        return path
    }
    
    
    //    CLEAR_DAY：晴天
    //    CLEAR_NIGHT：晴夜
    //    PARTLY_CLOUDY_DAY：多云
    //    PARTLY_CLOUDY_NIGHT：多云
    //    CLOUDY：阴
    //    RAIN： 雨
    //    SNOW：雪
    //    WIND：风
    //    FOG：雾
    ///处理天气概况中英文互转
    func conversionEng2Ch(text: String) -> String {
        var cnText = ""
        if text == "CLEAR_DAY" || text == "CLEAR_NIGHT"  {
            cnText = "晴"
        } else if text == "PARTLY_CLOUDY_DAY" || text == "PARTLY_CLOUDY_NIGHT" {
            cnText = "云"
        } else if text == "CLOUDY" {
            cnText = "阴"
        } else if text == "RAIN" {
            cnText = "雨"
        } else if text == "SNOW" {
            cnText = "雪"
        } else if text == "WIND" {
            cnText = "风"
        } else if text == "FOG" || text == "HAZE" {
            cnText = "雾"
        } else {
            cnText = "迷"
        }
        return cnText
    }
    
    ///删除对应的通知们
    func deleteNotification(model: FlagDataModel) {
        let weekdaysCount = model.weekdays.count
        for i in 0..<weekdaysCount {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [model.title + String(i)])
            UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [model.title + String(i)])
        }
    }
    
    
    ///地理信息反编码
    func reverseGeocode(latitude: Double, longitude: Double){
        let geocoder = CLGeocoder()
        let currentLocation = CLLocation(latitude: latitude, longitude: longitude)
        geocoder.reverseGeocodeLocation(currentLocation, completionHandler: {
            (placemarks:[CLPlacemark]?, error:Error?) -> Void in
            //强制转成简体中文
            let array = NSArray(object: "zh-hans")
            UserDefaults.standard.set(array, forKey: "AppleLanguages")
            //显示所有信息
            if error != nil {
                print("错误：\(error?.localizedDescription))")
                return
            }
            
            if let p = placemarks?[0]{
                //                print(p) //输出反编码信息
                var address = ""
                
                if let country = p.country {
                    address.append("国家：\(country)\n")
                }
                if let administrativeArea = p.administrativeArea {
                    address.append("省份：\(administrativeArea)\n")
                }
                if let subAdministrativeArea = p.subAdministrativeArea {
                    address.append("其他行政区域信息（自治区等）：\(subAdministrativeArea)\n")
                }
                if let locality = p.locality {
                    address.append("城市：\(locality)\n")
                    locality.replacingOccurrences(of: "市", with: "")
                    FlagTag.CITY = locality
                }
                if let subLocality = p.subLocality {
                    address.append("区划：\(subLocality)\n")
                }
                //                print(address)
            } else {
                print("No placemarks!")
            }
        })
    }
    
    
}





