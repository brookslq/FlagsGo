//
//  NewFlagViewController.swift
//  FlagsGo
//
//  Created by brooks on 2017/11/13.
//  Copyright © 2017年 brooks. All rights reserved.
//

import UIKit

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
        
        let flagtitle = newFlagV.flagtitleTF.text
        let flagslogan = newFlagV.flagsloganTF.text
        
        guard flagtitle?.characters.count != 0 && flagslogan?.characters.count != 0 else {
            noticeInfo("未填完信息！", autoClear: true, autoClearTime: 1)
            return
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
        
        //添加数据 -> 刷新UI准备
        let dataModel = FlagDataModel(datas: ["title": flagtitle!, "slogan": flagslogan!])
        FlagTag.flagDatas.append(dataModel)
        //发送监听 -> 刷新UI
        NotificationCenter.default.post(name: NSNotification.Name("newflag"), object: nil)
        
        //返回上一层界面
        self.navigationController?.popViewController(animated: true)
    }

}
