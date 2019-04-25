//
//  FollowViewController.swift
//  DYLive
//
//  Created by Mr_Han on 2019/4/25.
//  Copyright © 2019 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

import UIKit

private let kFollowHeaderViewH : CGFloat = 120.0

class FollowViewController: BaseAnchorViewController {
    
    fileprivate lazy var followViewModel : FollowViewModel = FollowViewModel()
    fileprivate lazy var followHeaderView : FollowHeaderView = {
        
        let followHeaderView = FollowHeaderView.followHeaderView()
        
        followHeaderView.frame = CGRect(x: 0, y: -kFollowHeaderViewH, width: kScreenW, height: kFollowHeaderViewH)
        
        return followHeaderView
        
    }()

}


// MARK: 设置 UI 界面
extension FollowViewController {
    
    override func setUpUI() {
        
        self.title = "关注"
        
        collectionView.addSubview(followHeaderView)
        collectionView.contentInset = UIEdgeInsets(top: kFollowHeaderViewH, left: 0, bottom: 0, right: 0)
        
        super.setUpUI()
    }
    
}


// MARK: 请求数据
extension FollowViewController {
    
    override func loadData() {
        
        //0. 给父类中 viewModel 赋值
        baseVM = followViewModel
        
        followViewModel.loadFollowData {
            
            //1. 刷新表格
            self.collectionView.reloadData()
            
            //1.2.3 数据请求完成
            self.loadDataFinished()
        }
        
    }
    
}


// MARK: 重写父类方法
extension FollowViewController {
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        //1. 取出 headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "kHeaderViewID", for: indexPath) as! CollectionHeaderView
        
        //2. 设置属性
        headerView.titleLabel.text = "推荐直播"
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        
        return headerView
        
    }
    
}
