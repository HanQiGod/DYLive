//
//  RoomVipViewController.swift
//  DYLive
//
//  Created by Mr_Han on 2019/4/28.
//  Copyright © 2019 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//  贵宾

import UIKit

private let kRankHeaderViewH : CGFloat = 80.0

private let kRankCellID = "kRankCellID"

class RoomVipViewController: BaseTableViewController {
    
    fileprivate lazy var roomRankHeaderView : RoomRankHeaderView = {
        let roomRankHeaderView = RoomRankHeaderView.roomRankHeaderView()
        roomRankHeaderView.frame = CGRect(x: 0, y: -kRankHeaderViewH, width: kScreenW, height: kRankHeaderViewH)
        roomRankHeaderView.segmentControl.isHidden = true
        return roomRankHeaderView
    }()
    
}

// MARK: 设置 UI 界面
extension RoomVipViewController {
    override func setUpUI() {
        count = 10
        tableView.rowHeight = 40
        tableView.register(UINib(nibName: "RoomRankCell", bundle: nil), forCellReuseIdentifier: kRankCellID)
        tableView.addSubview(roomRankHeaderView)
        tableView.contentInset = UIEdgeInsets(top: kRankHeaderViewH, left: 0, bottom: 0, right: 0)
        super.setUpUI()
    }
}

// MARK: 重写协议
extension RoomVipViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kRankCellID, for: indexPath) as! RoomRankCell
        var names : [String] = ["路飞","索隆","山治","娜美","乌索普","乔巴","罗宾","弗兰奇","布鲁克","甚平"]
        cell.nameLabel.text = names[indexPath.item]
        return cell
    }
}
