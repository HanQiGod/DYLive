//
//  AnchorGroupModel.swift
//  DYLive
//
//  Created by Mr_Han on 2019/4/17.
//  Copyright © 2019 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

import UIKit

class AnchorGroupModel: NSObject {
    
    // 注意：属性前需要添加 @objc，否者转换模型失败
    /// 该组中对应的房间信息
    @objc var room_list : [[String : NSObject]]? {
        // 方法二：属性监听器，监听属性的改变
        didSet {
            guard let room_list = room_list else { return }
            for dict in room_list {
                anchors.append(AnchorModel.init(dict: dict))
            }
        }
        
    }
    /// 组显示的标题
    @objc var tag_name : String = ""
    /// 组显示的图标
    @objc var icon_name : String = "home_header_normal"
    /// 定义主播的模型对象数组
    @objc lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    
    // MARK: 构造函数
    override init() {
        
    }
    
    init(dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
    /* 方法一：
    override func setValue(_ value: Any?, forKey key: String) {
        
        if key == "room_list" {
            if let dataArray = value as? [[String : NSObject]] {
                for dict in dataArray {
                    anchors.append(AnchorModel(dict: dict))
                }
            }
        }
        
    }
    */

}
