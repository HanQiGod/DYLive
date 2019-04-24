//
//  RoomShowBottomView.swift
//  DYLive
//
//  Created by Mr_Han on 2019/4/23.
//  Copyright © 2019 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

import UIKit

class RoomShowBottomView: UIView {
    
    // MARK: 定义属性
    var roomShowVc : UIViewController?

}

// MARK: 创建类方法
extension RoomShowBottomView {
    
    class func roomShowBottomView() -> RoomShowBottomView {
        return Bundle.main.loadNibNamed("RoomShowBottomView", owner: nil, options: nil)?.first as! RoomShowBottomView
    }
    
}


// MARK: 监听点击事件
extension RoomShowBottomView {
    
    @IBAction func roomShowBottomBtnsAction(_ sender: UIButton) {
        
        switch sender.tag {
        case 110:// 聊天
            
            break
        case 111:// 分享
            
            break
        case 112:// 礼物
            
            break
        case 113:// 粒子动画
            
            break
        default:
            break
        }
        
    }
    
}
