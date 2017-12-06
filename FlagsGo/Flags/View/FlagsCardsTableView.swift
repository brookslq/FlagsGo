//
//  FlagsCardsTableView.swift
//  FlagsGo
//  通过卡片流展示已添加的Flag
//  Created by brooks on 2017/11/13.
//  Copyright © 2017年 brooks. All rights reserved.
//

import UIKit
import UserNotifications

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
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "删除") { (action, actionIndexPath) in
       
            var nowFlags = UserDefaults.standard.array(forKey: FlagTag.FLAGS_TITLE) as? [String]
            var finishedFlags = UserDefaults.standard.array(forKey: FlagTag.FLAGS_HISTORY) as? [String]
            if finishedFlags == nil {
                finishedFlags = [String]()
            }
            
            //对存储的数据源进行 相应的增删
            for i in 0..<FlagTag.FLAG_DATAS.count {
                if FlagTag.FLAG_DATAS[i].title == nowFlags![indexPath.row] {
                    //删除 对应的 通知
                    DataCenter().deleteNotification(model: FlagTag.FLAG_DATAS[i])
                    
                    FlagTag.FLAG_DATAS_H.append(FlagTag.FLAG_DATAS[i])
                    FlagTag.FLAG_DATAS.remove(at: i)
                    break
                }
            }
            
            finishedFlags?.append(nowFlags![indexPath.row])
            nowFlags?.remove(at: indexPath.row)
            
            UserDefaults.standard.set(nowFlags, forKey: FlagTag.FLAGS_TITLE)
            UserDefaults.standard.set(finishedFlags, forKey: FlagTag.FLAGS_HISTORY)
            
            self.reloadData()
            
        }
        
        return [deleteAction]
    }
    
}

extension FlagsCardsTableView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FlagTag.FLAG_DATAS.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FlagTag.CELLID, for: indexPath) as! FlagTableViewCell
        cell.flagTitle.text = FlagTag.FLAG_DATAS[indexPath.row].title
        cell.flagSlogan
            .text = FlagTag.FLAG_DATAS[indexPath.row].slogan
        
        return cell
    }
    
}
