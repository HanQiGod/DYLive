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

// MARK: 定义常量
private let kScrollLineH : CGFloat = 2.0
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)


// MARK: 定义协议
protocol PageTitleViewDelegate : class {
    func pageTitleView(titleView: PageTitleView, selectedIndex index : Int)
}


// MARK: 定义 PPageTitleView 类
class PageTitleView: UIView {
    
    // MARK: 定义属性
    private var currentIndex : Int = 0
    private var titles : [String]
    weak var delegate : PageTitleViewDelegate?
    
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
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            
            //3. 设置 label 的 frame
            let labelX : CGFloat = labelW * CGFloat(index)
            
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //4. 将 label 添加到 scrollView 中
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            //5. 给 label 添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapG:)))
            label.addGestureRecognizer(tapGes)
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
        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        
        //2.2 设置 scrollLine 的属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
        
    }
    
}

// MARK: 监听 label 点击
extension PageTitleView {
    
    @objc private func titleLabelClick(tapG: UITapGestureRecognizer) {
        
        
        // 处理内部逻辑
        //0. 获取当前 Label
        guard let currentLabel = tapG.view as? UILabel else { return }
        
        //1. 如果是重复点击同一个 title，那么直接返回
        if currentLabel.tag == currentIndex { return }
        
        //2. 获取之前的 Label
        let oldLabel = titleLabels[currentIndex]
        
        //3. 切换文字的颜色
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        //4. 保存最新 Label 的下标值
        currentIndex = currentLabel.tag
        
        //5. 滚动条位置修改
        let scrollLinePosition = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLinePosition
        }
        
        
        // 处理外部逻辑
        //6. 通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
        
        
    }
    
}

// MARK: 对外暴露的方法
extension PageTitleView {
    
    func setTitleWithProgress(progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        
        //1. 取出 sourceLabel/targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        //2. 处理滑块逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //3. 颜色渐变(复杂)
        //3.1 取出变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        
        //3.2 变化 sourceLabel
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        
        //3.3 变化 targetLabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        //4. 记录最新的 index
        currentIndex = targetIndex
        
    }
    
}
