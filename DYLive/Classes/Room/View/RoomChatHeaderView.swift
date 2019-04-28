//
//  RoomChatHeaderView.swift
//  DYLive
//
//  Created by Mr_Han on 2019/4/28.
//  Copyright © 2019 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//  

import UIKit

class RoomChatHeaderView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        autoresizingMask = []
    }

}

// MARK: 类方法
extension RoomChatHeaderView {
    class func roomChatHeaderView() -> RoomChatHeaderView {
        return Bundle.main.loadNibNamed("RoomChatHeaderView", owner: nil, options: nil)?.first as! RoomChatHeaderView
    }
}
