//
//  UserViewController.swift
//  FlagsGo
//
//  Created by brooks on 2017/11/13.
//  Copyright © 2017年 brooks. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    var userView: UserInfoTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = UIColor.black
        view.backgroundColor = UIColor.initColor(r: 240, g: 240, b: 240, a: 0.8)
        userView = UserInfoTableView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height - 68), style: .grouped)
        userView.target = self
        view.addSubview(userView)
    }

 
}
