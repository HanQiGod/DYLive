//
//  RoomAnchorViewController.swift
//  DYLive
//
//  Created by Mr_Han on 2019/4/28.
//  Copyright © 2019 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//  主播

import UIKit

private let kAnchorViewH : CGFloat = 300.0

private let kAnchorDynamicCellID = "kAnchorDynamicCellID"


class RoomAnchorViewController: BaseTableViewController {
    
    // MARK: 懒加载属性
    fileprivate lazy var dynamicHeaderView : AnchorDynamicHeaderView = {
        let dynamicHeaderView = AnchorDynamicHeaderView.dynamicHeaderView()
        dynamicHeaderView.frame = CGRect(x: 0, y: -kAnchorViewH, width: kScreenW, height: kAnchorViewH)
        return dynamicHeaderView
    }()

}


// MARK: 重写 setUpUI
extension RoomAnchorViewController {
    override func setUpUI() {
        count = 10
        tableView.rowHeight = 300
        tableView.register(UINib(nibName: "AnchorDynamicCell", bundle: nil), forCellReuseIdentifier: kAnchorDynamicCellID)
        tableView.addSubview(dynamicHeaderView)
        tableView.contentInset = UIEdgeInsets(top: kAnchorViewH, left: 0, bottom: 0, right: 0)
        super.setUpUI()
    }
}


// MARK: 重写协议
extension RoomAnchorViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kAnchorDynamicCellID, for: indexPath) as! AnchorDynamicCell
        return cell
    }
}
