//
//  PageTitleView.swift
//  DYLive
//
//  Created by Mr_Han on 2019/4/15.
//  Copyright © 2019 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

import UIKit

private let kScrollLineH : CGFloat = 2.0

class PageTitleView: UIView {
    
    // MARK: 定义属性
    private var titles : [String]
    
    // MARK: 懒加载属性
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    // MARK: labels 数组
    private lazy var titleLabels : [UILabel] = [UILabel]()
    
    // MARK: 添加 scrollLine
    private lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        
        return scrollLine
    }()
    
    

    // MARK: 自定义构造函数
    init(frame: CGRect, titles: [String]) {
        
        self.titles = titles
        
        super.init(frame: frame)
        
        // 设置 UI 界面
        setUpUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: 设置 UI 界面
extension PageTitleView {
    
    private func setUpUI () {
        
        //1. 添加 ScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //2. 添加 title 对应的 Label
        setUpTitleLables()
        
        //3. 设置底线和滚动的滑块
        setUpBottomMenuAndScrollLine()
    }
    
    private func setUpTitleLables() {
        
        //0. 确定 label 的一些 frame 值
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            //1. 创建 UILabel
            let label = UILabel()
            
            //2. 设置 label 属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = .darkGray
            label.textAlignment = .center
            
            //3. 设置 label 的 frame
            let labelX : CGFloat = labelW * CGFloat(index)
            
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //4. 将 label 添加到 scrollView 中
            scrollView.addSubview(label)
            titleLabels.append(label)
        }
        
    }
    
    private func setUpBottomMenuAndScrollLine() {
        
        //1. 添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = .lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //2. 添加 scrollLine
        //2.1 获取第一个 Label
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = .orange
        
        //2.2 设置 scrollLine 的属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
        
    }
    
}

