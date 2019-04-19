//
//  CollectionBaseCell.swift
//  DYLive
//
//  Created by Mr_Han on 2019/4/18.
//  Copyright © 2019 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

import UIKit
import Kingfisher


class CollectionBaseCell: UICollectionViewCell {
    
    
    // MARK: 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    // MARK: 定义模型属性
    var anchor : AnchorModel? {
        
        didSet {
            
            //0. 校验模型是否有值
            guard let anchor = anchor else { return }
            
            //1. 取出在线人数显示的文字
            var onlineStr : String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            } else {
                onlineStr = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            
            //2. 昵称显示
            nickNameLabel.text = anchor.nickname
            
            //3. 设置图片封面
            guard let iconURL = NSURL(string: anchor.vertical_src) else { return }
            let url = ImageResource(downloadURL: iconURL as URL)
            iconImageView.kf.setImage(with: url)
            
        }
        
    }
    
}
