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
private let kNormalItemH : CGFloat = kItemW * 3 / 4
private let kPrettyItemH : CGFloat = kItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50.0

private let kCycleViewH : CGFloat = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90.0

private let kNormalCellID = "kNormalCellID"
private let kPrettyCellID = "kPrettyCellID"
private let kHeaderViewID = "kHeaderViewID"


class RecommendViewController: UIViewController {

    // MARK: 懒加载属性
    private lazy var recommendViewModel : RecommendViewModel = RecommendViewModel()
    private lazy var collectionView : UICollectionView = {[unowned self] in
        //1. 创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        //2. 创建 UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        return collectionView
    }()
    private lazy var cycleView : RecommendCycleView = {
        
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        
        return cycleView
        
    }()
    private lazy var gameView : RecommendGameView = {
        
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)

        return gameView
    }()
    
    // MARK: 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
   
        // 设置 UI 界面
        setUpUI()
        
        // 发送网络请求
        loadData()
        
    }

}


// MARK: 设置 UI 界面
extension RecommendViewController {
    
    private func setUpUI() {
        
        //1. 将 UICollectionView 添加到控制器 view 上
        view.addSubview(collectionView)
        
        //2. 将 cycleView 添加到 collectionView 上
        collectionView.addSubview(cycleView)
        
        //3. 将 gameView 添加到 collectionView 上
        collectionView.addSubview(gameView)
        
        //4. 设置 collectionView 的内边距
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
        
    }
    
}


// MARK: 请求数据
extension RecommendViewController {
    
    private func loadData() {
        
        //1. 请求推荐数据
        recommendViewModel.requestData {
            //1.1 展示推荐数据
            self.collectionView.reloadData()
            
            //1.2 将数据传递给 GameView
            self.gameView.groups = self.recommendViewModel.anchorGroups
        }
        
        //2. 请求轮播数据
        recommendViewModel.requestCycleData {
            self.cycleView.cycleModels = self.recommendViewModel.cycleModels
        }
        
    }
    
}


// MARK: 遵守 UICollectionViewDataSource 协议
extension RecommendViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendViewModel.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let group = recommendViewModel.anchorGroups[section]
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //1. 取出模型对象
        let group = recommendViewModel.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.row]
        
        //2. 定义 cell
        var cell : CollectionBaseCell!
        
        //3. 取出 cell
        if indexPath.section == 1 {
            
           cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            
        } else {
            
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        }
        
        //4. 将模型赋值 cell
        cell.anchor = anchor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        //1. 取出 section 的 headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID, for: indexPath) as!
        CollectionHeaderView
        
        //2. 取出模型
        headerView.group = recommendViewModel.anchorGroups[indexPath.section]
        
        return headerView
        
    }
    
}


// MARK: 遵循 UICollectionViewDelegateFlowLayout 协议
extension RecommendViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        
        return CGSize(width: kItemW, height: kNormalItemH)
    }
    
}
