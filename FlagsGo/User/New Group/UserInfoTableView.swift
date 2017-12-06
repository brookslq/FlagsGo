//
//  UserInfoTableView.swift
//  FlagsGo
//
//  Created by brooks on 2017/11/13.
//  Copyright © 2017年 brooks. All rights reserved.
//

import UIKit

class UserInfoTableView: UITableView {

    var content = ["回顾","收藏","反馈"]
    var target: UserViewController!
    let cellID = "cell"
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
        self.register(UserTableViewCell.self, forCellReuseIdentifier: cellID)
        self.separatorInset = .init(top: 0, left: 20, bottom: 0, right: 0)
        self.isScrollEnabled = false
        self.separatorInset.left = 0
        self.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UserInfoTableView: UITableViewDelegate {
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let collectVC = CollectViewController()
            target.navigationController?.pushViewController(collectVC, animated: true)
        } else if indexPath.section == 2 {
            let feedbackVC = FeedbackViewController()
            target.navigationController?.pushViewController(feedbackVC, animated: true)
        } else if indexPath.section == 0 {
            let historyVC = FlagsHistoryViewController()
            target.navigationController?.pushViewController(historyVC, animated: true)
            
        }
    }
    
}


extension UserInfoTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return content.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! UserTableViewCell
        cell.labInfo.text = content[indexPath.section]
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        return cell
    }
    
}
