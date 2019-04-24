//
//  ChatShowView.swift
//  DYLive
//
//  Created by Mr_Han on 2019/4/24.
//  Copyright © 2019 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

import UIKit

private let kChatViewCellID = "kChatViewCellID"

class ChatShowView: UIView {

    @IBOutlet weak var tableIView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 注册 cell
        tableIView.register(UINib(nibName: "ChatViewCell", bundle: nil), forCellReuseIdentifier: kChatViewCellID)
        
    }
    
}


// MARK: 创建类方法
extension ChatShowView {
    
    class func chatShowView() -> ChatShowView {
        return Bundle.main.loadNibNamed("ChatShowView", owner: nil, options: nil)?.first as! ChatShowView
    }
    
}


// MARK: 遵守 UITableViewDataSource 协议
extension ChatShowView : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: kChatViewCellID, for: indexPath) as! ChatViewCell
        
        var names : [String] = ["路飞","索隆","山治","娜美","乌索普","乔巴","罗宾","弗兰奇","布鲁克","甚平"]
        cell.chatContentLabel.text = names[indexPath.item] + "进入直播间"
        
        return cell
        
    }
    
    
}
