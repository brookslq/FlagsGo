//
//  RealWeather.swift
//  FlagsGo
//
//  Created by brooks on 2017/12/4.
//  Copyright © 2017年 brooks. All rights reserved.
//

import Foundation
import SwiftyJSON

class RealWeatherModel {
    
    var temperature: Float!    //温度
    var skycon: String!         //天气概况
    var speed: Float!          //风速
    var pm25: Float!              //pm25值
    
    
    init(json: JSON) {
        self.temperature = json["temperature"].float
        self.skycon = json["skycon"].string
        self.pm25 = json["pm25"].float
        self.speed = json["wind"]["speed"].float
    }
    
    
}
