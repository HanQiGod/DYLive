//
//  CustomNavigationVc.swift
//  DYLive
//
//  Created by Mr_Han on 2019/4/23.
//  Copyright © 2019 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

import UIKit

class CustomNavigationVc: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 实现全屏 Pop 手势实现：
        //1. 获取系统的 Pop 手势
        guard let systemGes = interactivePopGestureRecognizer else { return }
        
        //2. 获取手势添加的 view
        guard let gesView = systemGes.view else { return }
        
        //3. 获取 target/action
        //3.1 利用运行时机制，查看所有的属性名称
        /*
        var count : UInt32 = 0
        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
        for i in 0..<count {
            let ivar = ivars[Int(i)]
            let name = ivar_getName(ivar)
            print(String(cString: name!))
        }*/
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else { return }
        print(targetObjc)
        
        //3.2 取出 target
        guard let target = targetObjc.value(forKey: "target") else {return}
        
        //3.3 取出 action
        let action = Selector(("handleNavigationTransition:"))
        
        //4. 创建自己的 Pan 手势
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)
        

    }
    
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        //1. 隐藏要 push 的控制器的 tabbar
        viewController.hidesBottomBarWhenPushed = true
        
        super.pushViewController(viewController, animated: animated)
    }
    

}
