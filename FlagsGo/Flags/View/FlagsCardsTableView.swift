//
//  FlagsCardsTableView.swift
//  FlagsGo
//  通过卡片流展示已添加的Flag
//  Created by brooks on 2017/11/13.
//  Copyright © 2017年 brooks. All rights reserved.
//

import UIKit


class FlagsCardsTableView: UITableView {

//    var flagsData: [FlagDataModel] = []
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.tableFooterView = UIView(frame: CGRect.zero)
        self.rowHeight = 72
        self.delegate = self
        self.dataSource = self
        self.register(UINib.init(nibName: "FlagTableViewCell", bundle: nil), forCellReuseIdentifier: FlagTag.CELLID)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FlagsCardsTableView: UITableViewDelegate {
    
}

extension FlagsCardsTableView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FlagTag.flagDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FlagTag.CELLID, for: indexPath) as! FlagTableViewCell
        cell.flagTitle.text = FlagTag.flagDatas[indexPath.row].title
        cell.flagSlogan
            .text = FlagTag.flagDatas[indexPath.row].slogan
        
        return cell
    }
    
}
