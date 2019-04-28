//
//  RoomNormalContentView.swift
//  DYLive
//
//  Created by Mr_Han on 2019/4/26.
//  Copyright © 2019 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

import UIKit


protocol RoomNormalContentViewDelegate : class {
    func roomNormalContentView(contentView: RoomNormalContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}


private let kNormalContentCellID = "kNormalContentCellID"



class RoomNormalContentView: UIView {
    
    // MARK: 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: 定义属性
    var childVcs : [UIViewController] = []
    weak var parentViewController : UIViewController?
    fileprivate var startOffsetX : CGFloat = 0.0
    fileprivate var isForbidScrollDelegate : Bool = false
    weak var delegate : RoomNormalContentViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 注册 cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalContentCellID)
        
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = bounds.size
        
    }
    
}


// MARK: 类方法
extension RoomNormalContentView {
    class func roomNormalContentView() -> RoomNormalContentView {
        return Bundle.main.loadNibNamed("RoomNormalContentView", owner: nil, options: nil)?.first as! RoomNormalContentView
    }
}

// MARK: 设置 UI 界面
extension RoomNormalContentView {
    
    private func setUpUI() {
        
        //1. 将所有子控制添加到父控制器中
        for childVc in childVcs {
            parentViewController?.addChild(childVc)
        }
        
    }
    
}


// MARK: 遵守 UICollectionViewDataSource 协议
extension RoomNormalContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1. 取出 cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalContentCellID, for: indexPath)
        //2. 给 cell 设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.row]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}


// MARK: 遵守 UICollectionViewDelegate 协议
extension RoomNormalContentView : UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScrollDelegate = false
        
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //0. 判断是否是点击事件
        if isForbidScrollDelegate { return }
        
        //1. 定义获取需要的数据
        var progress : CGFloat = 0.0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        //2. 判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.frame.width
        if currentOffsetX > startOffsetX { // 左滑
            
            //2.1 计算 progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            //2.2 计算 sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            
            //2.3 计算 targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            //2.4 如果完全滑过去
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
            
        } else { // 右滑
            
            //2.1 计算 progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            //2.2 计算 targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            //2.3 计算 sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
            
        }
        
        //3. 将 progress/sourceIndex/targetIndex 传递给 titleView
        delegate?.roomNormalContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
    
}



// MARK: 对外暴露的方法
extension RoomNormalContentView {
    
    func setContentIndex(currentIndex: Int) {
        
        //1. 记录需要禁止进行代理方法
        isForbidScrollDelegate = true
        
        //2. 滚动到正确的位置
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
    
}
