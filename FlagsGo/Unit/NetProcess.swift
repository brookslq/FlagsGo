//
//  NetProcess.swift
//  FlagsGo
//
//  Created by brooks on 2017/12/1.
//  Copyright © 2017年 brooks. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetProcess {

    //MARK: - 诗词处理
    ///请求诗词数据并存储在模型之中
    func postPoem(target: PoemShowView) {
        Alamofire.request(FlagTag.POEM_URL).responseJSON{ response in
            guard response.result.isSuccess else {
                
                target.refreshBtn.isHidden = false
                return
            }
            let jsonData = JSON(response.value!)
            FlagTag.POEM_DATA = PoemModel(json: jsonData)
            
            let poemModel = DataCenter().readData(path: DataCenter().buildDataPath()) as? PoemModel
            guard poemModel?.content != FlagTag.POEM_DATA.content else {
                //确保刷新出来的诗词是以往没有收藏的
                self.postPoem(target: target)
                return
            }
            target.labTitle.text = FlagTag.POEM_DATA.title
            //自适应高度
            let size = CGSize(width: target.labTitle.width, height: CGFloat(MAXFLOAT))
            let actualSize = (target.labTitle.text)?.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 28)], context: nil).size
            target.labTitle.height = (actualSize?.height)!
            
            target.labInfo.y = target.labTitle.bottom + 10
            target.labInfo.text  = FlagTag.POEM_DATA.info
            
            let contentHeight = target.height - target.labTitle.height - target.labInfo.height - 20
            target.content.height = contentHeight
            target.content.y = target.labInfo.bottom + 10
            let content = self.processPoemContent(poemContent: FlagTag.POEM_DATA.content!)
            target.content.text = content
            //通过富文本来设置行间距
            let paraph = NSMutableParagraphStyle()
            //将行间距设置为28
            paraph.lineSpacing = 10
            //样式属性集合
            let attributes = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 24),
                              NSAttributedStringKey.paragraphStyle: paraph]
            target.content.attributedText = NSAttributedString(string: content, attributes: attributes)
        }
        
    }
    
    ///分割诗词内容成段落状态
    func processPoemContent(poemContent: String) -> String {
        let str = poemContent.replacingOccurrences(of: "，", with: "，\n")
        let str1 = str.replacingOccurrences(of: "。", with: "。\n")
        let str2 = str1.replacingOccurrences(of: "？", with: "？\n")
        let str3 = str2.replacingOccurrences(of: "一作夏日浮舟过陈逸人别业", with: "一作夏日浮舟过陈逸人别业\n")
        let str4 = str3.replacingOccurrences(of: "；", with: "；\n")
        let str5 = str4.replacingOccurrences(of: "：", with: "：\n")
        let str6 = str5.replacingOccurrences(of: "通：\n", with: "通：")
        let str7 = str6.replacingOccurrences(of: " ", with: "")
        let str8 = str7.replacingOccurrences(of: "[", with: "")
        var str9 = str8.replacingOccurrences(of: "]", with: "")
        
        for i in 1..<10 {
            str9 = str9.replacingOccurrences(of: "\(String(i))", with: "")
        }
        
        let str0 = str9.replacingOccurrences(of: "\n\n", with: "\n")
        let str01 = str0.replacingOccurrences(of: "！", with: "")
        let str02 = str01.replacingOccurrences(of: "!", with: "")
        let str03 = str02.replacingOccurrences(of: ";", with: "")
        return str03
    }
    
    //MARK: - 天气处理
    ///通过经纬度，获取当前天气状况数据
    func postCurrentWeatherData(target: MainWeatherView, longitude: String!, latitude: String!) {
        let url: String = FlagTag.WEATHER_URL + longitude + "," + latitude + "/realtime"
      
        Alamofire.request(url).responseJSON{ response in
            guard response.result.isSuccess else {
                print(response.error)
                return
            }
            let jsonData = JSON(response.value!)
            let json = jsonData["result"]
            
            let realWeather = RealWeatherModel(json: json)
            target.realTemp.text = String(format: "%.1f", realWeather.temperature) + "°C"
            let skycon = DataCenter().conversionEng2Ch(text: String(realWeather.skycon))
            target.realSkycon.text = skycon
            target.realWind.text = "外面风力达到：" + String(realWeather.speed) + "km/h"
            target.realPM25.text = "空中PM25指数：" + String(realWeather.pm25)
            
        }
        
        
        
    }
    
    ///通过经纬度，获取天气预测数据
    func postForecastWeatherData(target: MainWeatherView, longitude: String!, latitude: String!) {
        let url: String = FlagTag.WEATHER_URL + longitude + "," + latitude + "/forecast"
        
        Alamofire.request(url).responseJSON{ response in
            guard response.result.isSuccess else {
                print(response.error)
                return
            }
            let jsonData = JSON(response.value!)
            let json = jsonData["result"]["daily"]
            let jsonCount = json["temperature"].count
            var forecastWeathers = [ForecastWeatherModel]()
            
            for index in 0..<jsonCount {
                let forecastWeather = ForecastWeatherModel(json: json, index: index)
                forecastWeathers.append(forecastWeather)
            }
            target.setupForecastWeather(forecastWeathers: forecastWeathers)
    
        }
    }
    
}
