//
//  NewFlagInfoView.swift
//  FlagsGo
//
//  Created by brooks on 2017/11/13.
//  Copyright © 2017年 brooks. All rights reserved.
//

import UIKit

class NewFlagInfoView: UIView {

    var flagtitleTF:    NewFlagTextField!   //标题
    var flagsloganTF:   NewFlagTextField!   //口号
    var startBtn:       UIButton!           //开始时间
    var endBtn:         UIButton!           //截止时间
    
    var dateSelectBtn:  UIButton!           //中转选择时间的Button
    var dateSelect:     UIDatePicker!       //时间选择器
    var dateBgView:     UIView!             //日期选择器蒙层
    var _target:        UIViewController!
    
    private var contentView: UIView!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }



    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 设置UI
    func setupUI() {
        self.backgroundColor = UIColor.initColor(r: 240, g: 240, b: 240, a: 0.8)
        
        let flagtitle = UILabel(frame: CGRect(x: 16, y: 26, width: 56, height: 24))
        flagtitle.text = "插旗:"
        flagtitle.textColor = UIColor.black
        flagtitle.font = UIFont.boldSystemFont(ofSize: 20
        )
        flagtitle.textAlignment = .center
        self.addSubview(flagtitle)
        //12字数限制
        flagtitleTF = NewFlagTextField(frame: CGRect(x: flagtitle.right + 5, y: 22, width: self.width - 98, height: 30))
        flagtitleTF.backgroundColor = UIColor.white
        flagtitleTF.layer.cornerRadius = 2
        flagtitleTF.clipsToBounds = true
        flagtitleTF.placeholder = "立Flag于此！(12字以内)"
        flagtitleTF.font = UIFont.systemFont(ofSize: 20)
        flagtitleTF.delegate = self
        self.addSubview(flagtitleTF)
        
        let flagslogan = UILabel(frame: CGRect(x: 16, y: 84, width: 56, height: 24))
        flagslogan.text = "宣誓:"
        flagslogan.textColor = UIColor.black
        flagslogan.font = UIFont.boldSystemFont(ofSize: 20)
        flagslogan.textAlignment = .center
        self.addSubview(flagslogan)
        flagsloganTF = NewFlagTextField(frame: CGRect(x: flagslogan.right + 5, y: 80, width: self.width - 98, height: 30))
        flagsloganTF.backgroundColor = UIColor.white
        flagsloganTF.layer.cornerRadius = 2
        flagsloganTF.clipsToBounds = true
        flagsloganTF.placeholder = "人倒，旗不倒！(12字以内)"
        flagsloganTF.delegate = self
        flagsloganTF.font = UIFont.systemFont(ofSize: 20)
        self.addSubview(flagsloganTF)
        
        let timeBgView = UIView(frame: CGRect(x: 0, y: flagsloganTF.bottom + 24, width: self.width, height: 40))
        timeBgView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        self.addSubview(timeBgView)
        
        let zLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.width, height: 40))
        zLabel.text = "至"
        zLabel.textAlignment = .center
        timeBgView.addSubview(zLabel)
        
        startBtn = UIButton(frame: CGRect(x: 0, y: 0, width: self.width / 2, height: 40))
        startBtn.setTitle("开始升旗日", for: UIControlState.normal)
        startBtn.setTitleColor(UIColor.black.withAlphaComponent(0.4), for: UIControlState.normal)
        startBtn.addTarget(self, action: #selector(askDatePicker), for: UIControlEvents.touchUpInside)
        
        endBtn = UIButton(frame: CGRect(x: startBtn.right, y: 0, width: self.width / 2, height: 40))
        endBtn.setTitle("Flag招展时", for: UIControlState.normal)
        endBtn.setTitleColor(UIColor.black.withAlphaComponent(0.4), for: UIControlState.normal)
        endBtn.addTarget(self, action: #selector(askDatePicker), for: UIControlEvents.touchUpInside)
        
        timeBgView.addSubview(startBtn)
        timeBgView.addSubview(endBtn)
        
        dateBgView = UIView(frame: CGRect(x: 0, y: 0, width: self.width, height: self.height))
        dateBgView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        dateBgView.isHidden = true
        self.addSubview(dateBgView)
        //添加手势状态
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(hiddenDatePicker))
        singleTap.numberOfTapsRequired = 1
        dateBgView.addGestureRecognizer(singleTap)
        
        dateSelect = UIDatePicker(frame: CGRect(x: 0, y: self.height - 120 - 49, width: self.width, height: 120))
        dateSelect.datePickerMode = .date
        
        self.addSubview(dateSelect)
        dateSelect.isHidden = true
        
    }
    
    ///点击时间选择器背景 -> 时间选择器隐藏
    @objc func hiddenDatePicker() {
        
        if dateSelect.date < getCurrentTime() {
            print("比当前时间还早！")
            noticeTop("请选择比今天以后的日期", autoClear: true, autoClearTime: 2)
        } else {
            showAlter(title: "时间选择", messgae: getDateSelect(), button: dateSelectBtn)
            dateBgView.isHidden = true
            dateSelect.isHidden = true
            print("比当前时间还远！")
        }
    
    }

    ///提示框
    func showAlter(title: String, messgae: String, button: UIButton) {
        
        let alert = UIAlertController(title: title, message: messgae, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "确认", style: .default) {
           (action: UIAlertAction!) -> Void in
            
            button.setTitle(messgae, for: UIControlState.normal)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        _target.present(alert, animated: true, completion: nil)

    }
    
    
    ///打开时间选择器
    @objc func askDatePicker(button: UIButton) {
        dateBgView.isHidden = false
        //确保键盘回落
        flagsloganTF.resignFirstResponder()
        flagtitleTF.resignFirstResponder()
        dateSelect.isHidden = false
        
        dateSelectBtn = button
    }
    
    ///时间选择器值改变
    @objc func getDateSelect() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        return formatter.string(from: dateSelect.date)
    }
    
    ///获取当前时间
    func getCurrentTime() -> Date {
 
        let now = Date()
        //获取当前时间戳
        let timeInterval = now.timeIntervalSince1970
        let date = Date(timeIntervalSince1970: timeInterval)
        
        return date
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //点击空白 -> 键盘回落
        flagsloganTF.resignFirstResponder()
        flagtitleTF.resignFirstResponder()
    }
}

extension NewFlagInfoView: UITextFieldDelegate {
    
    //输入值改变的监听
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //如果是删除，则可以继续进行
        if(range.length != 0) {
            return true
        }//限制12个字符的输入
        else if (textField.text?.count)! >= 12 {
            noticeTop("请输入12字以内", autoClear: true, autoClearTime: 1)
            return false
        } else {
            return true
        }
    }

}
