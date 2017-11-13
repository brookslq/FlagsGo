//
//  UIImageView+Extension.swift
//  XCLearn
//
//  Created by brooks on 2017/9/5.
//  Copyright © 2017年 brooks. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    class func initUIImageView(frame: CGRect?, imageName: String?) -> UIImageView{
        let imageView = UIImageView.init(frame: frame ?? CGRect.zero)
        imageView.image = UIImage.init(named: imageName ?? "")
        return imageView
    }

}
