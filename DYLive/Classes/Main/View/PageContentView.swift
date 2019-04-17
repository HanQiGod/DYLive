//
//  PageContentView.swift
//  DYLive
//
//  Created by Mr_Han on 2019/4/15.
//  Copyright © 2019 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

import UIKit


protocol PageContentViewDelegate : class {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}

private let ContentCellID = "ContentCellID"


class PageContentView: UIView {
    
    // MARK: 定义属性
    private var childVcs : [UIViewController]
    private weak var parentViewController : UIViewController?
    private var startOffsetX : CGFloat = 0.0
    private var isForbidScrollDelegate : Bool = false
    weak var delegate : PageContentViewDelegate?
    
    // MARK: 懒加载属性
    private lazy var collectionView : UICollectionView = {[weak self] in
        //1. 创建 layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        
        //2. 创建 UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView
    }()

    // MARK: 自定义构造函数
    init(frame: CGRect, childVcs: [UIViewController], parentVc: UIViewController?) {
        
        self.childVcs = childVcs
        self.parentViewController = parentVc
        
        super.init(frame: frame)
        
        // 设置 UI
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


// MARK: 设置 UI 界面
extension PageContentView {
    
    private func setUpUI() {
        
        //1. 将所有子控制添加到父控制器中
        for childVc in childVcs {
            parentViewController?.addChild(childVc)
        }
        
        //2. 添加 UICollectionView 用于在 cell 中存放控制器 view
        addSubview(collectionView)
        collectionView.frame = bounds
        
    }
    
}

// MARK: 遵守 UICollectionViewDataSource 协议
extension PageContentView : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //1. 创建 cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
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
extension PageContentView : UICollectionViewDelegate {
    
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
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
    
}



// MARK: 对外暴露的方法
extension PageContentView {
    
    func setContentIndex(currentIndex: Int) {
        
        //1. 记录需要禁止进行代理方法
        isForbidScrollDelegate = true
        
        //2. 滚动到正确的位置
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
    
}
