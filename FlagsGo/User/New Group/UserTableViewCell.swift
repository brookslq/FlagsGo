//
//  UserTableViewCell.swift
//  FlagsGo
//
//  Created by brooks on 2017/12/4.
//  Copyright © 2017年 brooks. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    var labInfo: UILabel!
    var labContent: UILabel!
    var labBack: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        labInfo = UILabel.init(frame: .init(x: 30, y: 5, width: 60, height: 40))
        labInfo.textAlignment = .left
        labInfo.textColor = UIColor.darkGray
        self.addSubview(labInfo)
        
        labContent = UILabel.init(frame: .init(x: 260, y: 5, width: 90, height: 40))
        labContent.textAlignment = .right
        labContent.textColor = UIColor.darkGray
        self.addSubview(labContent)
        
        //返回
        labBack = UILabel.init(frame: .init(x: self.midX - 40, y: 3, width: 140, height: 40))
        labBack.text = "退出登录"
        labBack.font = UIFont.systemFont(ofSize: 26)
        labBack.textAlignment = .center
        labBack.isHidden = true
        self.addSubview(labBack)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
