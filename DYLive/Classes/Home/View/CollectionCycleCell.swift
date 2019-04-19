//
//  CollectionCycleCell.swift
//  DYLive
//
//  Created by Mr_Han on 2019/4/19.
//  Copyright © 2019 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

import UIKit
import Kingfisher

class CollectionCycleCell: UICollectionViewCell {
    
    // 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    

    // 定义模型属性
    var cycleModel : CycleModel? {
        
        didSet {
            
            titleLabel.text = cycleModel?.title
            let iconURL = URL(string: cycleModel?.pic_url ?? "")!
            let resource = ImageResource(downloadURL: iconURL)
            iconImageView.kf.setImage(with: resource, placeholder: UIImage(named: "Img_default"))
            
            
        }
        
    }
    

}
