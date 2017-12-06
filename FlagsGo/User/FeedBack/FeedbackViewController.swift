//
//  FeedbackViewController.swift
//  FlagsGo
//
//  Created by brooks on 2017/12/4.
//  Copyright © 2017年 brooks. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FeedbackViewController: UIViewController {
    
    //fb == feedback
    
    var fbTitle:    UITextField!          //标题
    var fbContent:  UITextView!           //内容
    var fbSubmit:   UIButton!             //提交
    var userName:   String!               //用户名
    
    var doneBtn: UIButton!
    
    var labPlaceholder: UILabel!
    let contentPlaceholder = "请填写10字以上的问题描述"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
//        let keychain = Keychain(service: Tag.userData)
//        userName = try? keychain.getString("userName") ?? ""
    }
    
    
    func setupUI() {
        title = "反馈"
        view.backgroundColor = UIColor.initColor(r: 240, g: 240, b: 240, a: 0.8)
        
        //顶部导航 设置添加Flag
        doneBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 56, height: 36))
        doneBtn.setTitle("提交", for: UIControlState.normal)
        doneBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        doneBtn.setTitleColor(UIColor.black.withAlphaComponent(0.8), for: UIControlState.highlighted)
        doneBtn.addTarget(self, action: #selector(postFeedBack), for: UIControlEvents.touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: doneBtn)
        
        fbTitle = UITextField(frame: CGRect(x: 0, y: 80, width: view.width, height: 48))
        fbTitle.backgroundColor = UIColor.white
        fbTitle.placeholder = "请输入标题"
        fbTitle.font = UIFont.systemFont(ofSize: 16)
        fbTitle.leftViewMode = .always
        let leftView = UIView(frame: CGRect(x: 0, y: 64, width: 16, height: 16))
        leftView.backgroundColor = UIColor.clear
        fbTitle.leftView = leftView

        view.addSubview(fbTitle)
        
        let subTitleLabel = UILabel(frame: CGRect(x: 16, y: fbTitle.bottom + 24, width: 80, height: 12))
        subTitleLabel.text = "反馈意见"
        subTitleLabel.textColor = UIColor.initColor(r: 136, g: 136, b: 136, a: 1)
        subTitleLabel.font = UIFont.systemFont(ofSize: 12)
        view.addSubview(subTitleLabel)
        
        fbContent = UITextView(frame: CGRect(x: 0, y: subTitleLabel.bottom + 8, width: view.width, height: 290))
        fbContent.backgroundColor = UIColor.white
        fbContent.font = UIFont.systemFont(ofSize: 14)
        fbContent.textContainerInset = UIEdgeInsetsMake(16, 13, 0, 13)
        fbContent.delegate = self
        
        labPlaceholder = UILabel(frame: CGRect(x: 18, y: 16, width: 200, height: 14))
        labPlaceholder.font = UIFont.systemFont(ofSize: 14)
        labPlaceholder.textColor = UIColor.lightGray.withAlphaComponent(0.78)
        labPlaceholder.text = contentPlaceholder
        fbContent.addSubview(labPlaceholder)
        view.addSubview(fbContent)
        
        fbSubmit = UIButton(frame: CGRect(x: 15, y: fbContent.bottom + 67, width: view.width - 30, height: 48))
        fbSubmit.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        fbSubmit.setTitle("提交", for: UIControlState.normal)
        fbSubmit.addTarget(self, action: #selector(postFeedBack), for: UIControlEvents.touchUpInside)
        fbSubmit.layer.cornerRadius = 24
        fbSubmit.clipsToBounds = true
        fbSubmit.setTitleColor(UIColor.white, for: UIControlState.normal)
        fbSubmit.setTitleColor(UIColor.white.withAlphaComponent(0.6), for: UIControlState.highlighted)
        view.addSubview(fbSubmit)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        fbContent.resignFirstResponder()
        fbTitle.resignFirstResponder()
    }
    
    ///提交反馈
    @objc func postFeedBack() {
        let fTitle: String = fbTitle.text!
        guard fTitle != "" else {
            noticeInfo("请输入标题！", autoClear: true, autoClearTime: 1)
            return
        }
        
        let fContent: String = fbContent.text
        
        guard fContent != "" && fContent.count > 10 else {
            noticeInfo("请填写10字以上的问题描述！", autoClear: true, autoClearTime: 1
            )
            return
        }
        
        let dic: [String : String] = ["title" : fTitle, "content" : fContent]
        let strUrl = "http://192.168.16.50:5000/feedback/"
        let url = strUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)


        Alamofire.request(url!, method: .post, parameters: dic ).responseJSON{ response in

            weak var weakself = self

//            guard response.result.isSuccess else {
//                print(response.result.error ?? "上传失败")
//                self.noticeInfo("上传失败！", autoClear: true, autoClearTime: 1)
//                return
//            }
            weakself?.noticeSuccess("提交成功", autoClear: true, autoClearTime: 1)
            weakself?.navigationController?.popViewController(animated: true)
        }
        
    }
    
}

extension FeedbackViewController: UITextViewDelegate {
    
    //做出提醒文字的效果
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.characters.count == 0 {
            labPlaceholder.isHidden = false
        } else {
            labPlaceholder.isHidden = true
        }
    }
    
    
}
