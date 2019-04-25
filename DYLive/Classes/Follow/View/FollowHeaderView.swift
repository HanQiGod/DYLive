//
//  FollowHeaderView.swift
//  DYLive
//
//  Created by Mr_Han on 2019/4/25.
//  Copyright © 2019 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

import UIKit

class FollowHeaderView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        autoresizingMask = []
    }

}


// MARK: 类方法
extension FollowHeaderView {
    
    class func followHeaderView() -> FollowHeaderView {
        return Bundle.main.loadNibNamed("FollowHeaderView", owner: nil, options: nil)?.first as! FollowHeaderView
    }
    
}
