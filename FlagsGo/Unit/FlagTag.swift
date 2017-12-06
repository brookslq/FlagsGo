//
//  Tag.swift
//  FlagsGo
//
//  Created by brooks on 2017/11/13.
//  Copyright © 2017年 brooks. All rights reserved.
//

import Foundation

class FlagTag {
    static let CELLID = "cell_id"
    //本地服务地址，
//    169.254.178.220   自己的热点
//    http://169.254.171.137 公司
    static let POEM_URL = "http://192.168.16.50:5000/"
    //flag模型
    static var FLAG_DATAS: [FlagDataModel] = []
    //flag的tag 用于存取被添加的 flag 的title, 可以通过title获取models
    static let FLAGS_TITLE = "flags_title"
    //flags的历史记录
    static let FLAGS_HISTORY = "flags_history"
    //flags历史记录对应的模型数组
    static var FLAG_DATAS_H: [FlagDataModel] = []
    //诗词模型
    static var POEM_DATA: PoemModel!
    //诗词收藏
    static let POEM_START = "poem_start"
    
    //彩云天气token
    static let WEATHER_TOKEN = "bWLuKCa0zi6CE62r"
    //彩云天气API主url
    static let WEATHER_URL = "https://api.caiyunapp.com/v2/" + FlagTag.WEATHER_TOKEN + "/"
    //地级市名字
    static var CITY = "迷城"
    //经纬度
    static var LONGITUDE = ""
    static var LAITUDE = ""
}
