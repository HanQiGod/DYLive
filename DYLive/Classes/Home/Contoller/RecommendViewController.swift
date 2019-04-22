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
private let kCycleViewH : CGFloat = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90.0


class RecommendViewController: BaseAnchorViewController {

    // MARK: 懒加载属性
    private lazy var recommendViewModel : RecommendViewModel = RecommendViewModel()
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

}


// MARK: 设置 UI 界面
extension RecommendViewController {
    
    override func setUpUI() {
        
        //1. 先调用 super.setUpUI()
        super.setUpUI()
        
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
    
    override func loadData() {
        
        //0. 给父类中 viewModel 赋值
        baseVM = recommendViewModel
        
        //1. 请求推荐数据
        recommendViewModel.requestData {
            //1.1 展示推荐数据
            self.collectionView.reloadData()
            
            //1.2 将数据传递给 GameView
            var groups = self.recommendViewModel.anchorGroups
            //1.2.1 先移除前两组数据
            groups.removeFirst()
            groups.removeFirst()
            
            //1.2.2 添加"更多"组
            let moreGroup = AnchorGroupModel()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            
            self.gameView.groups = groups
            
            //1.2.3 数据请求完成
            self.loadDataFinished()
        }
        
        //2. 请求轮播数据
        recommendViewModel.requestCycleData {
            self.cycleView.cycleModels = self.recommendViewModel.cycleModels
        }
        
    }
    
}



// MARK: 遵循 UICollectionViewDelegateFlowLayout 协议
extension RecommendViewController : UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 1 {
            //1. 取出 cell
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            
            //2. 设置数据
            prettyCell.anchor = recommendViewModel.anchorGroups[indexPath.section].anchors[indexPath.item]
            
            return prettyCell
        }
        
        return super.collectionView(collectionView, cellForItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }
        
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
    
}
