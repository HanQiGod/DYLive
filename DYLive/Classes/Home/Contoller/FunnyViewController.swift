//
//  FunnyViewController.swift
//  DYLive
//
//  Created by Mr_Han on 2019/4/22.
//  Copyright © 2019 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

import UIKit

private let kTopMargin : CGFloat = 8.0

class FunnyViewController: BaseAnchorViewController {
    
    // MARK: 懒加载模型对象
    fileprivate lazy var funnyVM : FunnyViewModel = FunnyViewModel()

}


extension FunnyViewController {
    
    override func setUpUI() {
        super.setUpUI()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsets(top: kTopMargin, left: 0, bottom: 0, right: 0)
    }
    
}


extension FunnyViewController {
    override func loadData() {
        
        //1. 给父类中的 viewModel 赋值
        baseVM = funnyVM
        
        //2. 请求数据
        funnyVM.loadFunnyData {
            //2.1 刷新表格
            self.collectionView.reloadData()
            
            //2.2 数据请求完成
            self.loadDataFinished()
        }
    }
}
