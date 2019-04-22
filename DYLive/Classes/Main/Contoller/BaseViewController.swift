//
//  BaseViewController.swift
//  DYLive
//
//  Created by Mr_Han on 2019/4/22.
//  Copyright © 2019 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: 定义属性
    var contentView : UIView?

    // MARK: 懒加载属性
    fileprivate lazy var animImageView : UIImageView = {[unowned self] in
        
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named: "img_loading_1")!, UIImage(named: "img_loading_2")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        
        return imageView
    }()
    
    // MARK: 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }

}


extension BaseViewController {
    
    @objc func setUpUI() {
        
        //1. 先隐藏内容 view
        contentView?.isHidden = true
        
        //2. 添加执行动画的 UIImageVIiew
        view.addSubview(animImageView)
        
        //3. 给 animImageView 执行动画
        animImageView.startAnimating()
        
        //4. 设置 view 的背景颜色
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }
    
    func loadDataFinished() {
        
        //1. 停止动画
        animImageView.stopAnimating()
        
        //2. 隐藏 animImageView
        animImageView.isHidden = true
        
        //3. 显示 contentView
        contentView?.isHidden = false
        
        
    }
    
    
}
