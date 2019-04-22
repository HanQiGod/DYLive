//
//  AmuseViewController.swift
//  DYLive
//
//  Created by Mr_Han on 2019/4/22.
//  Copyright © 2019 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

import UIKit

private let kMenuViewH : CGFloat = 200.0

class AmuseViewController: BaseAnchorViewController {
    
    // MARK: 懒加载属性
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    fileprivate lazy var menuView : AmuseMenuView = {
        
        let menuView = AmuseMenuView.amuseMenuView()
        
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
        
        return menuView
        
    }()

}

// MARK: 设置界面
extension AmuseViewController {
    
    override func setUpUI() {
        super.setUpUI()
        
        // 将菜单 View 添加到 collectionView 中
        collectionView.addSubview(menuView)
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
    }
    
}



// MARK: 请求数据
extension AmuseViewController {
    
    override func loadData() {
        
        //1. 给父类中的 viewModel 进行赋值
        baseVM = amuseVM
        
        //2. 请求数据
        amuseVM.loadAmuseData {
            //1. 刷新
            self.collectionView.reloadData()
            
            //2. 调整数据
            var tempGroups = self.amuseVM.anchorGroups
            tempGroups.removeFirst()
            self.menuView.groups = tempGroups
            
            //3. 数据请求完成
            self.loadDataFinished()
        }
    }
    
}



