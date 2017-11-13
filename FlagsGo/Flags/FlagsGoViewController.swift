//
//  FlagsGoViewController.swift
//  FlagsGo
//
//  Created by brooks on 2017/11/13.
//  Copyright © 2017年 brooks. All rights reserved.
//

import UIKit


class FlagsGoViewController: UIViewController {

    var addFlagBtn: UIButton!                       //添加Flag
    var flagsCardShowView: FlagsCardsTableView!     //列表展示Flag
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
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
 
    ///跳转 -> 添加Flag
    @objc func addFlagBtnClick() {
        let newflagVC = NewFlagViewController()
        self.navigationController?.pushViewController(newflagVC, animated: true)
    }
    
}
