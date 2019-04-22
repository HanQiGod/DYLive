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

private let kGameCellID = "kGameCellID"


class GameViewController: UIViewController {

    // MARK: 懒加载属性
    fileprivate lazy var gameVM : GameViewModel = GameViewModel()
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        
        //1. 创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMagrin, bottom: 0, right: kEdgeMagrin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        
        return collectionView
        
    }()
    
    // MARK: 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置 UI
        setUpUI()
        
        // 注册 cell
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)

    }

}


// MARK: 设置 UI 界面
extension GameViewController {
    
    fileprivate func setUpUI() {
        
        //1. 添加 collectionView 到 view 上
        view.addSubview(collectionView)
        
        //2. 请求数据
        loadData()
        
    }
    
}

// MARK: 请求数据
extension GameViewController {
    
    fileprivate func loadData() {
        
        gameVM.loadAllGameData {
            self.collectionView.reloadData()
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
    
}
