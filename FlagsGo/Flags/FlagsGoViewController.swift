//
//  FlagsGoViewController.swift
//  FlagsGo
//
//  Created by brooks on 2017/11/13.
//  Copyright © 2017年 brooks. All rights reserved.
//
import UIKit
import UserNotifications

class FlagsGoViewController: UIViewController {

    var addFlagBtn: UIButton!                       //添加Flag
    var flagsCardShowView: FlagsCardsTableView!     //列表展示Flag
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        checkData()
        //监听通知
        NotificationCenter.default.addObserver(self, selector: #selector(updateTableView), name: NSNotification.Name("newflag"), object: nil)
    }

    //MARK: - 监听响应
    @objc func updateTableView() {
        flagsCardShowView.reloadData()
    }
    
    //MARK: - 初始化UI
    func setupUI() {
        self.navigationController?.navigationBar.tintColor = UIColor.black
        //顶部导航 设置添加Flag
        addFlagBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        addFlagBtn.addTarget(self, action: #selector(addFlagBtnClick), for: UIControlEvents.touchUpInside)
        addFlagBtn.setImage(UIImage(named: "navbar_add_nor"), for: .normal)
        addFlagBtn.setImage(UIImage(named: "navbar_add_sel"), for: .highlighted)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addFlagBtn)
        
        flagsCardShowView = FlagsCardsTableView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height), style: .plain)
        view.addSubview(flagsCardShowView)
    }
    
    ///判断是否有数据进行显示
    func checkData() {
        
        var arry = UserDefaults.standard.array(forKey: FlagTag.FLAGS_TITLE) as? [String]
        guard arry != nil else {
            return
        }
        //准备当前日期
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        let dateStr = formatter.string(from: date)
        
        FlagTag.FLAG_DATAS.removeAll()
        var num = [Int]()
        //检查  是否有日期到期，有则不添加。移入历史记录
        for i in 0..<(arry?.count)! {
            let dataModel = DataCenter().readData(path: arry![i]) as? FlagDataModel
            if dataModel?.end != dateStr {
                FlagTag.FLAG_DATAS.append(dataModel!)
            } else {
                num.append(i)
            }
        }
        
        var history = UserDefaults.standard.object(forKey: FlagTag.FLAGS_HISTORY) as? [String]
        if history == nil {
            history = [String]()
        } else {
            for title in history! {
                let dataModel = DataCenter().readData(path: title) as? FlagDataModel
                FlagTag.FLAG_DATAS_H.append(dataModel!)
            }
        }
        //以标题名作为tag 添加到历史记录的列表  以便在【回顾】界面取值
        for n in num {
            history?.append(arry![n])
            let dataModel = DataCenter().readData(path: arry![n]) as? FlagDataModel
            FlagTag.FLAG_DATAS_H.append(dataModel!)
            //删除 对应的 通知
            DataCenter().deleteNotification(model: dataModel!)
        }
        UserDefaults.standard.set(history, forKey: FlagTag.FLAGS_HISTORY)
        
         flagsCardShowView.reloadData()
        
        guard num.count != 0 else {
            return
        }
        
        //清理arry
        for i in ((arry?.count)! - 1)...0 {
            for j in (num.count - 1) ... 0 {
                if i == num[j] {
                    arry?.remove(at: i)
                }
            }
        }
    }
    
    ///跳转 -> 添加Flag
    @objc func addFlagBtnClick() {
        let newflagVC = NewFlagViewController()
        self.navigationController?.pushViewController(newflagVC, animated: true)
    }

}
