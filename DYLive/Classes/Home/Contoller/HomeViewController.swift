//
//  HomeViewController.swift
//  DYLive
//
//  Created by Mr_Han on 2019/4/15.
//  Copyright © 2019 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

import UIKit

private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {

    // MARK: 懒加载属性
    private lazy var pageTitleView : PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        
        return titleView
    }()
    
    private lazy var pageContentView : PageContentView = {[weak self] in
        //1. 确定内容 frame
        let contentH = kScreenH - kNavigationBarH - kTitleViewH - kTabBarH
        let contentFrame = CGRect(x: 0, y:  kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        
        //2. 确定所有子控制器
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        childVcs.append(GameViewController())
        childVcs.append(AmuseViewController())
        childVcs.append(FunnyViewController())
        
        let pageContentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentVc: self)
        pageContentView.delegate = self
        
        return pageContentView
    }()
    
    // MARK: 系统的回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置 UI 页面
        setUpUI()
    }

}

// MARK: 设置 UI 界面
extension HomeViewController {
    
    private func setUpUI() {
        
        //0. 不需要调整 UIScrollView 的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        //1. 设置导航栏
        setUpNavigationBar()
        
        //2. 添加 titleView
        view.addSubview(pageTitleView)
        
        //3. 添加 contentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = .purple
        
    }
    
    private func setUpNavigationBar() {
        
        //1. 设置左侧 item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        //2. 设置右侧 item
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let grcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,grcodeItem]
        
    }
    
}

// MARK: 遵守 PageTitleViewDelegate 协议
extension HomeViewController : PageTitleViewDelegate {
    
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        
        pageContentView.setContentIndex(currentIndex: index)
        
    }
    
}


// MARK: 遵守 PageContentViewDelegate 协议
extension HomeViewController : PageContentViewDelegate {
    
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
}
