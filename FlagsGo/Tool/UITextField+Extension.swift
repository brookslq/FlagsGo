//
//  UITextField+Extention.swift
//  XCLearn
//
//  Created by brooks on 2017/9/4.
//  Copyright © 2017年 brooks. All rights reserved.
//

import Foundation
import UIKit

extension UITextField{
    
    ///扩展为 用户/密码 输入栏
    class func initUITextField(frame: CGRect?, backgroundColor: UIColor?, placeholder: String?, font: UIFont?, leftViewMode: UITextFieldViewMode?, leftView: UIView?, clearButtonMode: UITextFieldViewMode?, secureTextEntry: Bool?) -> UITextField{
        let textfield = UITextField(frame: frame ?? CGRect.zero)
        textfield.backgroundColor = backgroundColor ?? UIColor.clear
        textfield.placeholder = placeholder ?? ""
        textfield.font = font ?? UIFont.systemFont(ofSize: 10)
        textfield.leftViewMode = leftViewMode ?? .always
        textfield.clearButtonMode = clearButtonMode ?? .whileEditing
        textfield.isSecureTextEntry = secureTextEntry ?? false
        textfield.leftView = leftView ?? nil
        return textfield
    }
}
