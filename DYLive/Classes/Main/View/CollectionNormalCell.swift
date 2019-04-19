//
//  CollectionNormalCell.swift
//  DYLive
//
//  Created by Mr_Han on 2019/4/16.
//  Copyright © 2019 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

import UIKit

class CollectionNormalCell: CollectionBaseCell {
    
    // MARK: 控件属性
    @IBOutlet weak var roomNameLabel: UILabel!
    
    
    // MARK: 定义模型属性
    override var anchor : AnchorModel? {
        
        didSet {
            
            //1. 将属性传递给父类
            super.anchor = anchor
            
            //2. 房间名称
            roomNameLabel.text = anchor?.room_name
            
        }
        
    }

}
