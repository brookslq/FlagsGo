//
//  FlagDataModel.swift
//  FlagsGo
//
//  Created by brooks on 2017/11/13.
//  Copyright © 2017年 brooks. All rights reserved.
//

import Foundation

class FlagDataModel {
    //旗-标题
    var title: String!
    //旗-口号
    var slogan: String!
    
    init(datas: [String: String]) {
        self.title = datas["title"]
        self.slogan = datas["slogan"]
    }
}
