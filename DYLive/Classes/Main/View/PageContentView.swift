//
//  PageContentView.swift
//  DYLive
//
//  Created by Mr_Han on 2019/4/15.
//  Copyright © 2019 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

import UIKit

class PageContentView: UIView {
    
    // MARK: 定义属性
    private var childVcs : [UIViewController]
    private var parentVc : UIViewController

    // MARK: 自定义构造函数
    init(frame: CGRect, childVcs: [UIViewController], parentVc: UIViewController) {
        
        self.childVcs = childVcs
        self.parentVc = parentVc
        
        super.init(frame: frame)
        
        // 设置 UI
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


// MARK: 设置 UI 界面
extension PageContentView {
    
    private func setUpUI() {
        
        //1. 将所有子控制添加到父控制器中
        for childVc in childVcs {
//            parentViewController.add
        }
        
    }
    
}
