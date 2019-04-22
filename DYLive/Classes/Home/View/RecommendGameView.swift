//
//  RecommendGameView.swift
//  DYLive
//
//  Created by Mr_Han on 2019/4/19.
//  Copyright © 2019 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

import UIKit

private let kEdgeInsetMargin : CGFloat = 10.0

private let kGameCellID = "kGameCellID"


class RecommendGameView: UIView {
    
    // MARK: 定义数据属性
    var groups : [AnchorGroupModel]? {
        
        didSet {
            
            //1. 先移除前两组数据
            groups?.removeFirst()
            groups?.removeFirst()
            
            //2. 添加"更多"组
            let moreGroup = AnchorGroupModel()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
            
            //3. 刷新
            collectionView.reloadData()
            
        }
        
    }
    
    // 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 设置该控件不随父控件拉伸而拉伸，即设置为none或者空[]
        autoresizingMask = []
        
        // 注册 cell
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        
        // 给 collectionView 添加内边距
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsetMargin, bottom: 0, right: kEdgeInsetMargin)
        
    }

}


// MARK: 快速创建的类方法
extension RecommendGameView {
    
    class func recommendGameView() -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
    
}


// MARK: 遵守 UICollectionViewDataSource 协议
extension RecommendGameView : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        
        cell.baseGame = groups![indexPath.item]
        
        return cell
    }
    
}
