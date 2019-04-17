//
//  RecommendViewController.swift
//  DYLive
//
//  Created by Mr_Han on 2019/4/16.
//  Copyright © 2019 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

import UIKit

// MARK: 常量
private let kItemMargin : CGFloat = 10.0
private let kItemW : CGFloat = (kScreenW - kItemMargin * 3) / 2
private let kItemH : CGFloat = kItemW * 3 / 4
private let kHeaderViewH : CGFloat = 50.0

private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"


class RecommendViewController: UIViewController {

    // MARK: 懒加载属性
    private lazy var collectionView : UICollectionView = {[unowned self] in
        //1. 创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        //2. 创建 UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    // MARK: 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
   
        // 设置 UI 界面
        setUpUI()

    }

}


// MARK: 设置 UI 界面
extension RecommendViewController {
    
    private func setUpUI() {
        
        //1. 将 UICollectionView 添加到控制器 view 上
        view.addSubview(collectionView)
        
    }
    
}


// MARK: 遵守 UICollectionViewDataSource 协议
extension RecommendViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 8
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //1. 获取 cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
                
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        //1. 取出 section 的 headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID, for: indexPath)
        
        return headerView
        
    }
    
}
