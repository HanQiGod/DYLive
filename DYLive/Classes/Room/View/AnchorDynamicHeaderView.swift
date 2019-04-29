//
//  AnchorDynamicHeaderView.swift
//  DYLive
//
//  Created by 君凯商联网 on 2019/4/29.
//  Copyright © 2019 君凯商联网. All rights reserved.
//

import UIKit

class AnchorDynamicHeaderView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        autoresizingMask = []
    }

}


// MARK: 类方法
extension AnchorDynamicHeaderView {
    class func dynamicHeaderView() -> AnchorDynamicHeaderView {
        return Bundle.main.loadNibNamed("AnchorDynamicHeaderView", owner: nil, options: nil)?.first as! AnchorDynamicHeaderView
    }
}
