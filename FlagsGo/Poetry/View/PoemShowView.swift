//
//  PoemShowView.swift
//  FlagsGo
//
//  Created by brooks on 2017/12/1.
//  Copyright © 2017年 brooks. All rights reserved.
//

import UIKit

class PoemShowView: UIView {
    
    var labTitle : UILabel!     //诗词名
    var labInfo  : UILabel!     //年代、作者
    var content  : UITextView!
    
    lazy var refreshBtn: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: self.width, height: self.height))
        button.setTitle("快来点我刷新，再次召唤诗词", for: UIControlState.normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28)
        button.setTitleColor(UIColor.black, for: UIControlState.normal)
        button.setTitleColor(UIColor.black.withAlphaComponent(0.6), for: UIControlState.highlighted)
        button.addTarget(self, action: #selector(refreshUI), for: UIControlEvents.touchUpInside)
        button.isHidden = true
        self.addSubview(button)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.backgroundColor = UIColor.white
        
        labTitle = UILabel(frame: CGRect(x: 10, y: 20, width: self.width - 20, height: 40))
        labTitle.font = UIFont.boldSystemFont(ofSize: 28)
        labTitle.textColor = UIColor.black
        labTitle.textAlignment = .left
        labTitle.lineBreakMode = .byWordWrapping
        labTitle.numberOfLines = 0

        self.addSubview(labTitle)
        
        labInfo = UILabel(frame: CGRect(x: 24, y: labTitle.bottom + 10, width: self.width - 34, height: 16))
        labInfo.font = UIFont.systemFont(ofSize: 14)
        labInfo.textColor = UIColor.black
        labInfo.textAlignment = .left
        self.addSubview(labInfo)
        
        content = UITextView(frame: CGRect(x: 20, y: labInfo.bottom + 10, width: self.width - 40, height: 280))
        content.isScrollEnabled = true
        content.isEditable = false
        content.textAlignment = .left
        content.textColor = UIColor.black
        self.addSubview(content)
    }

    @objc func refreshUI() {
        NetProcess().postPoem(target: self)
        refreshBtn.isHidden = true
    }
    
}
