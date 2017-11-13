//
//  PoetryViewController.swift
//  FlagsGo
//  诗情 -> 画意 -> 知音
//  Created by brooks on 2017/11/13.
//  Copyright © 2017年 brooks. All rights reserved.
//

import UIKit

class PoetryViewController: UIViewController {

    var moreFuncBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

   
    func setupUI() {
        self.navigationController?.navigationBar.tintColor = UIColor.black
        moreFuncBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        moreFuncBtn.addTarget(self, action: #selector(moreFuncBtnClick), for: UIControlEvents.touchUpInside)
        moreFuncBtn.setImage(UIImage(named: "navbar_add_nor"), for: .normal)
        moreFuncBtn.setImage(UIImage(named: "navbar_add_sel"), for: .highlighted)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: moreFuncBtn)
    }

    ///弹出 -> 更多功能：分享、收藏、上传（自己喜欢的诗词）
    @objc func moreFuncBtnClick() {
        
        
    }
}
