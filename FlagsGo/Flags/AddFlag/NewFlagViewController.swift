//
//  NewFlagViewController.swift
//  FlagsGo
//
//  Created by brooks on 2017/11/13.
//  Copyright © 2017年 brooks. All rights reserved.
//

import UIKit
import UserNotifications

class NewFlagViewController: UIViewController {

    var doneBtn: UIButton!
    var newFlagV: NewFlagInfoView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    func setupUI() {
        self.title = "插旗"
        view.backgroundColor = UIColor.white
        
        //顶部导航 设置添加Flag
        doneBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 56, height: 36))
        doneBtn.setTitle("完成", for: UIControlState.normal)
        doneBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        doneBtn.setTitleColor(UIColor(red: 138/255, green: 138/255, blue: 138/255, alpha: 1), for: UIControlState.highlighted)
        doneBtn.addTarget(self, action: #selector(doneBtnClick), for: UIControlEvents.touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: doneBtn)
        
        newFlagV = NewFlagInfoView(frame: CGRect(x: 0, y: 64, width: view.width, height: view.height - 64))
        newFlagV._target = self
        
        view.addSubview(newFlagV)
        
    }
    
    ///点击 -> 结束 返回
    @objc func doneBtnClick() {
        
        let flagtitle: String = newFlagV.flagtitleTF.text!
        let flagslogan: String = newFlagV.flagsloganTF.text!
        
        guard flagtitle.count != 0 && flagslogan.count != 0 else {
            noticeInfo("未填完信息", autoClear: true, autoClearTime: 1)
            return
        }
        
        let titles = UserDefaults.standard.array(forKey: FlagTag.FLAGS_TITLE) as? [String]

        if titles != nil && (titles?.count)! > 0 {
            for title in titles! {
                if flagtitle == title {
                    noticeInfo("旗名有重复", autoClear: true, autoClearTime: 1)
                    return
                }
            }
        }
        
        //判断时间的选择是否符合逻辑
        let startDate: String = (newFlagV.startBtn.titleLabel?.text)!
        let endDate: String = (newFlagV.endBtn.titleLabel?.text)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        
        let dateTimeS: Date = dateFormatter.date(from: startDate)!
        let dateTimeE: Date = dateFormatter.date(from: endDate)!
        
        guard dateTimeS != dateTimeE else {
            noticeTop("时间不能为同一天", autoClear: true, autoClearTime: 2)
            return
        }
        
        guard dateTimeS < dateTimeE else {
            noticeTop("升旗时间不能在Flag招展日之后", autoClear: true, autoClearTime: 2)
            return
        }
        
        //如果没有选择天数，则默认每天
        if newFlagV.selectWeekday.count == 0 {
            newFlagV.selectWeekday = [1,2,3,4,5,6,7,8]
        }
        
        //添加数据 -> 刷新UI准备
        let dataModel = FlagDataModel(title: flagtitle, slogan: flagslogan, start: (newFlagV.startBtn.titleLabel?.text)!, end: (newFlagV.endBtn.titleLabel?.text)!, clock: (newFlagV.selectTimeBtn.titleLabel?.text)!, weekdays: newFlagV.selectWeekday)
        //设置该Flag的本地通知
        setupNotification(dataModel: dataModel)
        FlagTag.FLAG_DATAS.append(dataModel)
        
        //存储数据
        DataCenter().saveData(path: dataModel.title, data: dataModel)
        var arry = UserDefaults.standard.array(forKey: FlagTag.FLAGS_TITLE) as? [String]
        if arry == nil {
            arry = [String]()
            arry?.append(dataModel.title)
        } else {
            arry?.append(dataModel.title)
        }
        UserDefaults.standard.set(arry, forKey: FlagTag.FLAGS_TITLE)
        
        //发送监听 -> 刷新UI
        NotificationCenter.default.post(name: NSNotification.Name("newflag"), object: nil)
        
        //返回上一层界面
        self.navigationController?.popViewController(animated: true)
    }

    func setupNotification(dataModel: FlagDataModel) {
        //在这里配置本地通知
        let localNotification = UNMutableNotificationContent()
        localNotification.title = dataModel.title
        localNotification.body = dataModel.slogan
        localNotification.badge = 1
        localNotification.sound = UNNotificationSound.default()
        
        //如果没有选择天数 则默认每天
        let count = dataModel.weekdays.count
        //按日期重复
        
        for i in 0..<count  {
            var components = DateComponents()
            components.weekday = dataModel.weekdays[i] //星期天默认是1，星期一是2……
            components.hour = Int(dataModel.clock.mySubString(to: 2))
//            print(dataModel.clock.mySubString(to: 2))
            var minute = dataModel.clock.mySubString(from: 3)
            for num in 0...10 {
                minute = minute.replacingOccurrences(of: "0"+String(num), with: "\(num)")
            }
            components.minute = Int(minute)
//            print(dataModel.clock.mySubString(from: 3))
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
            let request = UNNotificationRequest(identifier: dataModel.title + String(i), content: localNotification, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
                print("seccess")
            })
        }
        
        
        
        
        
//
    }
    
}
