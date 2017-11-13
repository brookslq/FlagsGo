//
//  NewFlagInfoView.swift
//  FlagsGo
//
//  Created by brooks on 2017/11/13.
//  Copyright © 2017年 brooks. All rights reserved.
//

import UIKit

class NewFlagInfoView: UIView {

    var flagtitleTF:    UITextField!
    var flagsloganTF:   UITextField!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI() {
        self.backgroundColor = UIColor.initColor(r: 240, g: 240, b: 240, a: 0.8)
        
        let flagtitle = UILabel(frame: CGRect(x: 10, y: 20, width: 56, height: 24))
        flagtitle.text = "插旗:"
        flagtitle.textColor = UIColor.black
        flagtitle.font = UIFont.boldSystemFont(ofSize: 18)
        flagtitle.textAlignment = .center
        self.addSubview(flagtitle)
        flagtitleTF = UITextField(frame: CGRect(x: flagtitle.right + 5, y: 20, width: self.width - 81, height: 24))
        flagtitleTF.backgroundColor = UIColor.white
        flagtitleTF.layer.cornerRadius = 2
        flagtitleTF.clipsToBounds = true
        flagtitleTF.placeholder = "每天都要学英语！"
        self.addSubview(flagtitleTF)
        
        let flagslogan = UILabel(frame: CGRect(x: 10, y: 64, width: 56, height: 24))
        flagslogan.text = "旗号:"
        flagslogan.textColor = UIColor.black
        flagslogan.font = UIFont.boldSystemFont(ofSize: 18)
        flagslogan.textAlignment = .center
        self.addSubview(flagslogan)
        flagsloganTF = UITextField(frame: CGRect(x: flagslogan.right + 5, y: 64, width: self.width - 81, height: 24))
        flagsloganTF.backgroundColor = UIColor.white
        flagsloganTF.layer.cornerRadius = 2
        flagsloganTF.clipsToBounds = true
        flagsloganTF.placeholder = "誓死学好英语，不然是猪头！"
        self.addSubview(flagsloganTF)
        
        
    }
    
}
