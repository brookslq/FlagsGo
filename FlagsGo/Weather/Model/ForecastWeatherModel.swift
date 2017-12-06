//
//  ForecastWeather.swift
//  FlagsGo
//
//  Created by brooks on 2017/12/4.
//  Copyright © 2017年 brooks. All rights reserved.
//

import Foundation
import SwiftyJSON

class ForecastWeatherModel {
    
    var date: String!
    var skycon: String!
    var tempMin: Float!
    var tempMax: Float!
    
    init(json: JSON, index: Int) {
        self.date = json["temperature"][index]["date"].string
        self.tempMax = json["temperature"][index]["max"].float
        self.tempMin = json["temperature"][index]["min"].float
        self.skycon = json["skycon"][index]["value"].string
    }
    
}
