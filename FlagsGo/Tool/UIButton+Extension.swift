//
//  UIView+Extention.swift
//  XCLearn
//
//  Created by brooks on 2017/9/4.
//  Copyright © 2017年 brooks. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    ///初始化含图片的Button （注：可以通过设置 UIEdgeInsets 让图片和文字的位置进行调整）
    class func initImageButton(frame: CGRect? ,norImgName: String?, seleImgName: String?, norTitle: String?, seleTitle: String?, norTitleColor: UIColor?, seleTitleColor: UIColor?, titleFont: UIFont?) -> UIButton {
        let button = UIButton(frame: frame ?? CGRect.zero)
        button.setImage(UIImage(named: norImgName ?? ""), for: .normal)
        button.setImage(UIImage(named: seleImgName ?? ""), for: .selected)
        button.setTitle(norTitle ?? "", for: .normal)
        button.setTitle(seleTitle ?? norTitle, for: .selected)
        button.setTitleColor(norTitleColor ?? UIColor.darkText, for: .normal)
        button.setTitleColor(seleTitleColor ?? norTitleColor, for: .selected)
        button.titleLabel?.font = titleFont ?? UIFont.systemFont(ofSize: 10)
        return button       
    }
    
    ///提供给侧边栏用的Button
    class func initSideButton(frame: CGRect?, leftImgName: String?, rightImgName: String?, isRightViewHidden: Bool?, text: String?, fontSize: CGFloat, textColor: [CGFloat]) -> UIButton {
        
        let button = UIButton(frame: frame ?? CGRect.zero)
        
        let imgLeftView = UIImageView(frame: CGRect(x: 24, y: 20, width: 30, height: 30))
        imgLeftView.image = UIImage(named: leftImgName ?? "")
        button.addSubview(imgLeftView)
        
        let label = UILabel(frame: CGRect(x: imgLeftView.right + 18, y: 25, width: 100, height: 21))
        label.text = text ?? ""
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textColor = UIColor.initColor(r: textColor[0], g: textColor[1], b: textColor[2], a: textColor[3])
        button.addSubview(label)
        
        let imgRightView = UIImageView(frame: CGRect(x: 230 - 26, y: 28, width: 15, height: 15))
//        imgRightView.right = 230 - 16
        imgRightView.image = UIImage(named: rightImgName ?? "")
        imgRightView.isHidden = isRightViewHidden ?? true
        button.addSubview(imgRightView)
        
        return button
    
    }
    
    
    ///初始化地图类型Button
    class func initMapBtn(frame: CGRect?, defaultImgName: String?, selectedImgName: String?) -> UIButton {
        let button = UIButton.init(frame: frame ?? CGRect.zero)
        button.setImage(UIImage(named: defaultImgName ?? ""), for: .normal)
        button.setImage(UIImage(named: selectedImgName ?? ""), for: .selected)
        return button
    }
    
    ///设置不同状态下的Button背景色
    func setBackgroundColor(color: UIColor, forState: UIControlState) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(colorImage, for: forState)
    }
}
