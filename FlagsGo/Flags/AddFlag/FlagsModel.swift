//
//  FlagsModel.swift
//  FlagsGo
//
//  Created by brooks on 2017/11/22.
//  Copyright © 2017年 brooks. All rights reserved.
//

import Foundation

class FlagsModel: NSObject {
    
    var title:      String!
    var slogan:     String!
    var start:      Date!
    var end:        Date!
    
    init(title: String, slogan: String, start: Date, end: Date) {
        self.title = title
        self.slogan = slogan
        self.start = start
        self.end = end
    }
}
