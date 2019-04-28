//
//  RoomShowViewController.swift
//  DYLive
//
//  Created by Mr_Han on 2019/4/23.
//  Copyright © 2019 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

import UIKit

private let kRoomShowHeaderViewH : CGFloat = 88.0
private let kRoomShowFooterViewH : CGFloat = 88.0


class RoomShowViewController: UIViewController {
    
    // MARK: 懒加载属性
    fileprivate lazy var roomShowHeaderView : RoomShowHeadView = {
        
        let roomShowHeaderView = RoomShowHeadView.roomShowHeadView()
        
        roomShowHeaderView.frame = CGRect(x: 0, y: kStatusBarH, width: kScreenH, height: kRoomShowHeaderViewH)
        
        return roomShowHeaderView
        
    }()
    fileprivate lazy var roomShowBottomView : RoomShowBottomView = {
        
        let roomShowBottomView = RoomShowBottomView.roomShowBottomView()
        
        roomShowBottomView.frame = CGRect(x: 0, y: kScreenH-kRoomShowFooterViewH, width: kScreenW, height: kRoomShowFooterViewH)
        
        return roomShowBottomView
        
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置 UI 界面
        setUpUI()

    }

}


// MARK: 设置 UI 界面
extension RoomShowViewController {
    
    fileprivate func setUpUI() {
        
        let img = UIImageView(image: UIImage(named: "IMG_5042"))
        img.frame = view.bounds
        img.contentMode = .scaleAspectFill
        view.addSubview(img)
        
        roomShowHeaderView.roomShowVc = self
        view.addSubview(roomShowHeaderView)
        
        roomShowBottomView.roomShowVc = self
        view.addSubview(roomShowBottomView)
        
    }
    
}
