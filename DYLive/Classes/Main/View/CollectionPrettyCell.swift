//
//  CollectionPrettyCell.swift
//  DYLive
//
//  Created by Mr_Han on 2019/4/17.
//  Copyright © 2019 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

import UIKit

class CollectionPrettyCell: CollectionBaseCell {
    
    // MARK: 控件属性
    @IBOutlet weak var cityBtn: UIButton!
    
    // MARK: 定义模型属性
    override var anchor : AnchorModel? {
        
        didSet {
            
            //1. 将属性传递给父类
            super.anchor = anchor
            
            //2. 所在城市
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
            
        }
        
    }

}
