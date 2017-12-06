//
//  PoemModel.swift
//  FlagsGo
//
//  Created by brooks on 2017/12/1.
//  Copyright © 2017年 brooks. All rights reserved.
//

import Foundation
import SwiftyJSON

class PoemModel: NSObject, NSCoding {
    
    ///诗词模型： 诗词名、背景、内容、标签
    var title:   String!
    var info :   String!
    var content: String!
    var tag:     String!
    
    init(json: JSON) {
        self.title   = json["title"].stringValue
        self.info    = json["info"].stringValue
        self.content = json["content"].stringValue
        self.tag     = json["tag"].stringValue
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(info, forKey: "info")
        aCoder.encode(content, forKey: "content")
        aCoder.encode(tag, forKey: "tag")
    }
    
    required init?(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObject(forKey: "title") as! String
        info = aDecoder.decodeObject(forKey: "info") as! String
        content = aDecoder.decodeObject(forKey: "content") as! String
        tag = aDecoder.decodeObject(forKey: "tag") as! String
    }
    
}
