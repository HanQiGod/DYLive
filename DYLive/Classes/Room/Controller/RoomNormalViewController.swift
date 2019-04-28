//
//  RoomNormalViewController.swift
//  DYLive
//
//  Created by Mr_Han on 2019/4/23.
//  Copyright © 2019 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

import UIKit

private let kFooterMargin : CGFloat = kIsPhoneX ? 20.0 : 0.0
private let kBarButtonItemW : CGFloat = 49.0
private let kNormalFooterViewH : CGFloat = 55.0
private let kNormalVideoViewH : CGFloat = kScreenH * 3 / 7


class RoomNormalViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: 懒加载属性
    fileprivate lazy var leftButtonItem : UIBarButtonItem = {
        let leftButtonItem = UIBarButtonItem(imageName: "btn_bp_back_white", highImageName: "", size: CGSize(width: kBarButtonItemW, height: kBarButtonItemW), viewController: self, selector: #selector(goBack))
        return leftButtonItem
    }()
    fileprivate lazy var rightButtonOneItem : UIBarButtonItem = { // 蓝光4M
        let rightButtonOneItem = UIBarButtonItem(imageName: "dy_send_remind", highImageName: "", size: CGSize(width: kBarButtonItemW, height: kBarButtonItemW), viewController: self, selector: #selector(blueAction))
        return rightButtonOneItem
    }()
    fileprivate lazy var rightButtonTwoItem : UIBarButtonItem = { // TV
        let rightButtonTwoItem = UIBarButtonItem(imageName: "btn_dm_all", highImageName: "", size: CGSize(width: kBarButtonItemW, height: kBarButtonItemW), viewController: self, selector: #selector(tvAction))
        return rightButtonTwoItem
    }()
    fileprivate lazy var rightButtonThreeItem : UIBarButtonItem = { // 录像
        let rightButtonThreeItem = UIBarButtonItem(imageName: "dyla_icon_cover_upload_camera_big", highImageName: "", size: CGSize(width: kBarButtonItemW, height: kBarButtonItemW), viewController: self, selector: #selector(videoAction))
        return rightButtonThreeItem
    }()
    fileprivate lazy var rightButtonFourItem : UIBarButtonItem = { // ...
        let rightButtonFourItem = UIBarButtonItem(imageName: "btn_dm_bottom", highImageName: "", size: CGSize(width: kBarButtonItemW, height: kBarButtonItemW), viewController: self, selector: #selector(moreAction))
        return rightButtonFourItem
    }()
    fileprivate lazy var rightButtonFiveItem : UIBarButtonItem = { // 分享
        let rightButtonFiveItem = UIBarButtonItem(imageName: "shortvideo_navItem_share", highImageName: "", size: CGSize(width: kBarButtonItemW, height: kBarButtonItemW), viewController: self, selector: #selector(shareAction))
        return rightButtonFiveItem
    }()
    
    fileprivate lazy var footerView : RoomNormalFooterView = {
        let footerView = RoomNormalFooterView.roomNormalFooterView()
        footerView.frame = CGRect(x: 0, y: kScreenH - kNormalFooterViewH - kFooterMargin, width: kScreenW, height: kNormalFooterViewH)
        return footerView
    }()
    
    fileprivate lazy var videoView : RoomNormalVideoView = {[weak self] in
        let videoView = RoomNormalVideoView.roomNormalVideoView()
        videoView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kNormalVideoViewH)
        videoView.titles = ["聊天","主播","排行榜","贵宾(26)"]
        videoView.delegate = self
        return videoView
    }()
    fileprivate lazy var contentView : RoomNormalContentView = {[weak self] in
        let contentView = RoomNormalContentView.roomNormalContentView()
        contentView.frame = CGRect(x: 0, y: kNormalVideoViewH, width: kScreenW, height: kScreenH - kNormalVideoViewH - kFooterMargin - kNormalFooterViewH)
        contentView.childVcs = [RoomChatViewController(),RoomAnchorViewController(),RoomRankViewController(),RoomVipViewController()]
        contentView.parentViewController = self
        contentView.delegate = self
        return contentView
    }()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置 UI
        setUpUI()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 设置导航栏透明色
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        // 隐藏导航栏
//        navigationController?.setNavigationBarHidden(true, animated: true)        
        // 依然保持系统的手势方法
//        navigationController?.interactivePopGestureRecognizer?.delegate = self
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 显示导航栏
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    

}


// 设置 UI 界面
extension RoomNormalViewController {
    
    func setUpUI() {
        
        view.backgroundColor = .white
        
        // 添加 barButtonItem
        navigationItem.leftBarButtonItem = leftButtonItem
        navigationItem.rightBarButtonItems = [rightButtonFiveItem,rightButtonFourItem,rightButtonThreeItem,rightButtonTwoItem,rightButtonOneItem]
        
        // 添加 videoView 和 contentView
        view.addSubview(videoView)
        view.addSubview(contentView)
        
        // 添加底部视图
        view.addSubview(footerView)
        
    }
    
}


// MARK: 监听事件点击
extension RoomNormalViewController {
    
    @objc fileprivate func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc fileprivate func blueAction() {
        print("蓝光4M")
    }
    
    @objc fileprivate func tvAction() {
        print("TV")
    }
    
    @objc fileprivate func videoAction() {
        print("录像")
    }
    
    @objc fileprivate func moreAction() {
        print("更多")
    }
    
    @objc fileprivate func shareAction() {
        print("分享")
    }
    
}


// MARK: 遵守 RoomNormalVideoViewDelegate 协议
extension RoomNormalViewController : RoomNormalVideoViewDelegate {
    
    func roomNormalVideoView(titleView: RoomNormalVideoView, selectedIndex index: Int) {
        contentView.setContentIndex(currentIndex: index)
        footerView.isHidden = index > 0 ? true : false
    }
    
}


// MARK: 遵守 RoomNormalContentViewDelegate 协议
extension RoomNormalViewController : RoomNormalContentViewDelegate {
    
    func roomNormalContentView(contentView: RoomNormalContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        videoView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        footerView.isHidden = targetIndex > 0 ? true : false
    }
    
}

