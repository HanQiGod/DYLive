//
//  BaseTableViewController.swift
//  DYLive
//
//  Created by Mr_Han on 2019/4/28.
//  Copyright © 2019 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

import UIKit

let kChatCellID = "kChatCellID"


class BaseTableViewController: UIViewController {
    
    // MARK: 定义属性
    var count : Int = 0
    
    // MARK: 懒加载属性
    lazy var tableView : UITableView = {[unowned self] in
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.backgroundColor = UIColor(r: 244, g: 245, b: 245)
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.rowHeight = 40
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ChatViewCell", bundle: nil), forCellReuseIdentifier: kChatCellID)
        return tableView
        }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置 UI
        setUpUI()
    }

}


// MARK: 设置 UI 界面
extension BaseTableViewController {
    @objc func setUpUI() {
        
        view.addSubview(tableView)
                
    }
}


// MARK: 遵守
extension BaseTableViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kChatCellID, for: indexPath) as! ChatViewCell
        return cell
    }
}

