//
//  PoetryViewController.swift
//  FlagsGo
//  诗情 -> 画意 -> 知音
//  Created by brooks on 2017/11/13.
//  Copyright © 2017年 brooks. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PoetryViewController: UIViewController {

    var moreFuncBtn : UIButton!
    var refreshBtn  : UIButton!
    var poemShowView: PoemShowView!
    
    var isFromCollect = false
    var poemPath = ""
    
    override func viewWillAppear(_ animated: Bool) {
        if !animated {
            checkStart()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        //如果不是来自收藏的子页，则不显示刷新按钮
        guard !isFromCollect else {
            
            moreFuncBtn.isSelected = true
            setupPoemView()
            return
        }
        setupLeftBtn()
        NetProcess().postPoem(target: poemShowView)        
        
    }
    
    
    ///保证收藏状态的逻辑一致性
    func checkStart() {
        guard FlagTag.POEM_DATA != nil else {
            return
        }
        
        let arry = UserDefaults.standard.array(forKey: FlagTag.POEM_START) as? [String]
        guard arry != nil else {
            return
        }
        
        let mItem = DataCenter().buildDataPath()
        var i = 0
        for item in arry! {
            if mItem == item {
                i += 1
                break
            }
        }
        
        if i == 1 {
            moreFuncBtn.isSelected = true
        } else {
            moreFuncBtn.isSelected = false
        }
        
    }

    ///如果页面是从【收藏】进来 则执行
    func setupPoemView() {
        let dataPath = poemPath.replacingOccurrences(of: " ", with: "")
        let poemModel = DataCenter().readData(path: dataPath) as? PoemModel
        
        poemShowView.labTitle.text = poemModel?.title
        //自适应高度
        let size = CGSize(width: poemShowView.labTitle.width, height: CGFloat(MAXFLOAT))
        let actualSize = (poemShowView
            .labTitle.text)?.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 28)], context: nil).size
        poemShowView.labTitle.height = (actualSize?.height)!
        
        poemShowView.labInfo.y = poemShowView.labTitle.bottom + 10
        poemShowView.labInfo.text  = poemModel?.info
        
        let contentHeight = poemShowView.height - poemShowView.labTitle.height - poemShowView.labInfo.height - 20
        poemShowView.content.height = contentHeight
        poemShowView.content.y = poemShowView.labInfo.bottom + 10
        let content = NetProcess().processPoemContent(poemContent: (poemModel?.content)!)
        poemShowView.content.text = content
        //通过富文本来设置行间距
        let paraph = NSMutableParagraphStyle()
        //将行间距设置为28
        paraph.lineSpacing = 10
        //样式属性集合
        let attributes = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 24),
                          NSAttributedStringKey.paragraphStyle: paraph]
        poemShowView.content.attributedText = NSAttributedString(string: content, attributes: attributes)
    }
    
    func setupLeftBtn() {
        refreshBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        refreshBtn.addTarget(self, action: #selector(refreshClick), for: UIControlEvents.touchUpInside)
        refreshBtn.setImage(UIImage(named: "refresh_nor"), for: .normal)
        refreshBtn.setImage(UIImage(named: "refresh_sel"), for: .highlighted)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: refreshBtn)
    }
    
    func setupUI() {
        self.navigationController?.navigationBar.tintColor = UIColor.black
        moreFuncBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        moreFuncBtn.addTarget(self, action: #selector(moreFuncBtnClick), for: UIControlEvents.touchUpInside)

        moreFuncBtn.setImage(UIImage(named: "func_collects_nor"), for: .normal)
        moreFuncBtn.setImage(UIImage(named: "func_collects_sel"), for: .selected)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: moreFuncBtn)

        //主流机型适配
        poemShowView = PoemShowView(frame: CGRect(x: 0, y: 64, width: view.width, height: view.height - 108))
        view.addSubview(poemShowView)
    }

    @objc func refreshClick() {
        NetProcess().postPoem(target: poemShowView)
        moreFuncBtn.isSelected = false
    }
    
    ///弹出 -> 更多功能：分享、收藏、上传（自己喜欢的诗词）
    @objc func moreFuncBtnClick() {
        //v1. 目前只有一个收藏的功能
        collectFunc()
    }
    
    
    func collectFunc() {
        
        guard poemShowView.refreshBtn.isHidden else {
            noticeTop("无数据无法收藏", autoClear: true, autoClearTime: 1)
            return
        }
        
        //先判断是否收藏，无，则收藏，有，则提示
        let userDefault = UserDefaults.standard
        var arry = userDefault.array(forKey: FlagTag.POEM_START) as? [String]
        if arry == nil {
            //只有第一次收藏时才会进入
            arry = [String]()
        }

        var path = ""
        if isFromCollect {
            path = poemPath
        } else {
            path = DataCenter().buildDataPath()
        }
        
        let dataPath = path.replacingOccurrences(of: " ", with: "")
        
        if moreFuncBtn.isSelected {
            let count = arry?.count
            
            for i in 0..<count! {
                if arry![i] == path {
                    arry?.remove(at: i)
                    userDefault.set(arry, forKey: FlagTag.POEM_START)
                    break
                }
            }
            DataCenter().deleteData(path: dataPath)
            noticeInfo("取消收藏", autoClear: true, autoClearTime: 1)
            
        } else {
            DataCenter().saveData(path: dataPath, data: FlagTag.POEM_DATA)
            arry?.append(path)
            userDefault.set(arry, forKey: FlagTag.POEM_START)
            noticeSuccess("收藏成功", autoClear: true, autoClearTime: 1)
        }
        moreFuncBtn.isSelected = !moreFuncBtn.isSelected
    }
    
}
