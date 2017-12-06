//
//  FlagDataModel.swift
//  FlagsGo
//
//  Created by brooks on 2017/11/13.
//  Copyright © 2017年 brooks. All rights reserved.
//

import Foundation

class FlagDataModel: NSObject, NSCoding{
    
    //旗-标题
    var title:      String!
    //旗-口号
    var slogan:     String!
    //开始日期
    var start:      String!
    //结束日期
    var end:        String!
    //选择提醒周期    存储选择的周一至周天  其中，周天返回值为1，周一为2……
    var weekdays:   [Int] = []
    //提醒时刻
    var clock:  String!
    
    init(title: String, slogan: String, start: String, end: String, clock: String, weekdays: [Int]) {
        self.title = title
        self.slogan = slogan
        self.start = start
        self.end = end
        self.clock = clock
        self.weekdays = weekdays
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(slogan, forKey: "slogan")
        aCoder.encode(start, forKey: "start")
        aCoder.encode(end, forKey: "end")
        aCoder.encode(clock, forKey: "clock")
        aCoder.encode(weekdays, forKey: "weekdays")
    }
    
    required init?(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObject(forKey: "title") as! String
        slogan = aDecoder.decodeObject(forKey: "slogan") as! String
        start = aDecoder.decodeObject(forKey: "start") as! String
        end = aDecoder.decodeObject(forKey: "end") as! String
        clock = aDecoder.decodeObject(forKey: "clock") as! String
        weekdays = aDecoder.decodeObject(forKey: "weekdays") as! [Int]
    }
    
    
    
}
