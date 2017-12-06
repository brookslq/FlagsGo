//
//  FlagsHistoryTableViewCell.swift
//  FlagsGo
//
//  Created by brooks on 2017/12/5.
//  Copyright © 2017年 brooks. All rights reserved.
//

import UIKit

class FlagsHistoryTableViewCell: UITableViewCell {

    var poemName: UILabel!
    
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
        poemName = UILabel(frame: CGRect(x: 20, y:0, width: self.width - 20, height: self.height))
        self.addSubview(poemName)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
