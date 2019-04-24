//
//  RoomShowHeadView.swift
//  DYLive
//
//  Created by Mr_Han on 2019/4/23.
//  Copyright © 2019 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

import UIKit

class RoomShowHeadView: UIView {

    // MARK: 定义属性
    var roomShowVc : UIViewController?
    

}


// MARK: 创建类方法
extension RoomShowHeadView {
    
    class func roomShowHeadView() -> RoomShowHeadView {
        return Bundle.main.loadNibNamed("RoomShowHeadView", owner: nil, options: nil)?.first as! RoomShowHeadView
    }
    
}


// MARK: 监听点击方法
extension RoomShowHeadView {
    
    @IBAction func popRoomShow(_ sender: Any) {
        
        roomShowVc?.dismiss(animated: true, completion: nil)
        
    }
    
}
