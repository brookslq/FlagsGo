//
//  CollectViewController.swift
//  FlagsGo
//
//  Created by brooks on 2017/12/4.
//  Copyright © 2017年 brooks. All rights reserved.
//

import UIKit

class CollectViewController: UIViewController {

    var poemTableView: UITableView!
    var poemStart: [String] = []
    
    
    ///确保从【诗词】页返回【收藏】时刷新tbaleview
    override func viewWillAppear(_ animated: Bool) {
        if animated {
            if poemTableView != nil && poemStart.count != 0 {
                //获取收藏的诗词名列表
                poemStart = UserDefaults.standard.object(forKey: FlagTag.POEM_START) as! [String]
                poemTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //获取收藏的诗词名列表
        let userdefault = UserDefaults.standard
        let temp = userdefault.object(forKey: FlagTag.POEM_START) as? [String]
        guard temp != nil else {
            setupUI()
            return
        }
        poemStart = temp!
        setupUI()
    }

    func setupUI() {
        title = "收藏"
        poemTableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height), style: .plain)
        poemTableView.tableFooterView = UIView(frame: CGRect.zero)
        poemTableView.delegate = self
        poemTableView.dataSource = self
        poemTableView.register(CollectTableViewCell.self, forCellReuseIdentifier: FlagTag.CELLID)
        view.addSubview(poemTableView)
        
    }

}

extension CollectViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let poemPath = poemStart[indexPath.row]
        let poemVC = PoetryViewController()
        poemVC.isFromCollect = true
        poemVC.poemPath = poemPath        
        self.navigationController?.pushViewController(poemVC, animated: true)
    }
}

extension CollectViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return poemStart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       var cell = tableView.dequeueReusableCell(withIdentifier: FlagTag.CELLID, for: indexPath) as? CollectTableViewCell
        if cell == nil {
            cell = CollectTableViewCell(style: .default, reuseIdentifier: FlagTag.CELLID)
        }
        
        let str = poemStart[indexPath.row].mySubString(from: 2)
        let str0 = str
        let str1 = str0.replacingOccurrences(of: "作者:", with: "")
        let str2 = str1.replacingOccurrences(of: "_", with: "")
        cell?.accessoryType = .disclosureIndicator
        cell?.poemName.text = str2
        return cell!
        
    }
    
    
}
