//
//  MainViewController.swift
//  DYLive
//
//  Created by Mr_Han on 2019/4/12.
//  Copyright © 2019 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVc("Home")
        addChildVc("Live")
        addChildVc("Follow")
        addChildVc("Profile")
        
    }
    
    private func addChildVc(_ name : String) {
        
        //1. 通过 storyboard 来获取控制器
        let childVc = UIStoryboard(name: name, bundle: nil).instantiateInitialViewController()!
        
        //2. 将自控制器添加
        addChild(childVc)
        
    }
    

}
