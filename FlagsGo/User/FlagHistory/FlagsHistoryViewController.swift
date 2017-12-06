//
//  FlagsHistoryViewController.swift
//  FlagsGo
//
//  Created by brooks on 2017/12/5.
//  Copyright © 2017年 brooks. All rights reserved.
//

import UIKit

class FlagsHistoryViewController: UIViewController {

    var historyTableView: UITableView!
    var flagsData: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //获取收藏的诗词名列表
        let userdefault = UserDefaults.standard
        let temp = userdefault.object(forKey: FlagTag.FLAGS_HISTORY) as? [String]
        guard temp != nil else {
            setupUI()
            return
        }
        flagsData = temp!
        
        //保证即便未进入【旗扬】 也保证数据是可读状态而不是 nil
        var history = UserDefaults.standard.object(forKey: FlagTag.FLAGS_HISTORY) as? [String]
        if history == nil {
            history = [String]()
            FlagTag.FLAG_DATAS_H = []
        } else {
            for title in history! {
                let dataModel = DataCenter().readData(path: title) as? FlagDataModel
                FlagTag.FLAG_DATAS_H.append(dataModel!)
            }
        }
        
        setupUI()
    }
    
    func setupUI() {
        title = "回顾"
        historyTableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height), style: .plain)
        historyTableView.tableFooterView = UIView(frame: CGRect.zero)
//        historyTableView.delegate = self
        historyTableView.dataSource = self
        historyTableView.rowHeight = 72
        historyTableView.register(UINib.init(nibName: "FlagTableViewCell", bundle: nil), forCellReuseIdentifier: FlagTag.CELLID)
        view.addSubview(historyTableView)
        
    }
    
}

//extension FlagsHistoryViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    }
//}

extension FlagsHistoryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flagsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: FlagTag.CELLID, for: indexPath) as? FlagTableViewCell
        if cell == nil {
            cell = FlagTableViewCell(style: .default, reuseIdentifier: FlagTag.CELLID)
        }
        
        cell?.flagTitle.text = FlagTag.FLAG_DATAS_H[indexPath.row].title
        cell?.flagSlogan.text = FlagTag.FLAG_DATAS_H[indexPath.row].slogan
        
        return cell!
        
    }
    
    
}
