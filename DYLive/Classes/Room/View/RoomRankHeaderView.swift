//
//  RoomRankHeaderView.swift
//  DYLive
//
//  Created by Mr_Han on 2019/4/28.
//  Copyright © 2019 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

import UIKit

class RoomRankHeaderView: UIView {
    
    // MARK: 控件属性
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var bgImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        autoresizingMask = []
    }

}

// MARK: 类方法
extension RoomRankHeaderView {
    class func roomRankHeaderView() -> RoomRankHeaderView {
        return Bundle.main.loadNibNamed("RoomRankHeaderView", owner: nil, options: nil)?.first as! RoomRankHeaderView
    }
}
