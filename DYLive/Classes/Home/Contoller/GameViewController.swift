//
//  GameViewController.swift
//  DYLive
//
//  Created by Mr_Han on 2019/4/19.
//  Copyright © 2019 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

import UIKit

private let kEdgeMagrin : CGFloat = 10.0
private let kItemW : CGFloat = (kScreenW - 2 * kEdgeMagrin) / 3
private let kItemH : CGFloat = kItemW * 6 / 5
private let KHeaderViewH : CGFloat = 50.0
private let kGameViewH : CGFloat = 90.0

private let kGameCellID = "kGameCellID"
private let kHeaderViewID = "kHeaderViewID"


class GameViewController: BaseViewController {

    // MARK: 懒加载属性
    fileprivate lazy var gameVM : GameViewModel = GameViewModel()
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        
        //1. 创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMagrin, bottom: 0, right: kEdgeMagrin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: KHeaderViewH)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        
        // 注册 cell
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        return collectionView
        
    }()
    fileprivate lazy var topHeaderView : CollectionHeaderView = {
        
        let headerView = CollectionHeaderView.collectionHeaderView()
        
        headerView.frame = CGRect(x: 0, y: -(KHeaderViewH + kGameViewH), width: kScreenW, height: KHeaderViewH)
        headerView.titleLabel.text = "常见"
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        
        return headerView
        
    }()
    fileprivate lazy var gameView : RecommendGameView = {
        
        let gameView = RecommendGameView.recommendGameView()
        
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        
        return gameView
        
    }()
    
    // MARK: 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置 UI
        setUpUI()
        
        // 请求数据
        loadData()

    }

}


// MARK: 设置 UI 界面
extension GameViewController {
    
    override func setUpUI() {
        
        //0. 给 contentView 进行赋值
        contentView = collectionView
        
        //1. 添加 collectionView 到 view 上
        view.addSubview(collectionView)
        
        //2. 添加顶部的 headerView
        collectionView.addSubview(topHeaderView)
        
        //3. 将常用游戏的 view 添加到 collectionView 上
        collectionView.addSubview(gameView)
        
        // 设置 collectionView 的内边距
        collectionView.contentInset = UIEdgeInsets(top: KHeaderViewH + kGameViewH, left: 0, bottom: 0, right: 0)
        
        super.setUpUI()
    }
    
}

// MARK: 请求数据
extension GameViewController {
    
    fileprivate func loadData() {
        
        gameVM.loadAllGameData {
            
            //1. 展示全部游戏
            self.collectionView.reloadData()
            
            //2. 展示常用游戏
            self.gameView.groups = Array(self.gameVM.games[0..<10]) // 取出前十条数据
            
            //3. 数据请求完成
            self.loadDataFinished()
        }
        
    }
    
}


// 遵守 UICollectionViewDataSource 协议
extension GameViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        
        cell.baseGame = gameVM.games[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        //1. 取出 headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        //2. 设置属性
        headerView.titleLabel.text = "全部"
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        
        return headerView
        
    }
    
}
