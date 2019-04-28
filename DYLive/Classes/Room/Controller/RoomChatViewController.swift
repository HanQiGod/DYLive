//
//  RoomChatViewController.swift
//  DYLive
//
//  Created by Mr_Han on 2019/4/26.
//  Copyright © 2019 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//  聊天

import UIKit

private let kChatHeaderViewH : CGFloat = 100.0

class RoomChatViewController: BaseTableViewController {
    
    // MARK: 懒加载属性
    fileprivate lazy var roomChatHeaderView : RoomChatHeaderView = {
        let roomChatHeaderView = RoomChatHeaderView.roomChatHeaderView()
        roomChatHeaderView.frame = CGRect(x: 0, y: -kChatHeaderViewH, width: kScreenW, height: kChatHeaderViewH)
        return roomChatHeaderView
    }()

}


// MARK: 设置 UI 界面
extension RoomChatViewController {
    override func setUpUI() {
        
        tableView.addSubview(roomChatHeaderView)
        
        tableView.contentInset = UIEdgeInsets(top: kChatHeaderViewH, left: 0, bottom: 0, right: 0)
        
        count = 10
        
        super.setUpUI()
    }
}

// MARK: 重写协议
extension RoomChatViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kChatCellID, for: indexPath) as! ChatViewCell
        var names : [String] = ["路飞","索隆","山治","娜美","乌索普","乔巴","罗宾","弗兰奇","布鲁克","甚平"]
        cell.chatContentLabel.textColor = .black
        cell.chatContentLabel.text = names[indexPath.item] + "光临直播间"
        return cell
    }
}


