//
//  AppDelegate.swift
//  DYLive
//
//  Created by Mr_Han on 2019/4/12.
//  Copyright © 2019 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //1. 设置 Tabbar 的 tintColor
        UITabBar.appearance().tintColor = .orange
        
        return true
    }


}

