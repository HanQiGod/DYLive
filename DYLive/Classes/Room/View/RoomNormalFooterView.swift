//
//  RoomNormalFooterView.swift
//  DYLive
//
//  Created by Mr_Han on 2019/4/26.
//  Copyright © 2019 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

import UIKit
import ExpandingMenu

class RoomNormalFooterView: UIView {
    
    // MARK: 控件属性
    @IBOutlet weak var menuView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 添加 menuButtons
        menuButtons()
    }
    
}


// MARK: 类方法
extension RoomNormalFooterView {
    class func roomNormalFooterView() -> RoomNormalFooterView {
        return Bundle.main.loadNibNamed("RoomNormalFooterView", owner: nil, options: nil)?.first as! RoomNormalFooterView
    }
}


// MARK: 创建 Menu 按钮
extension RoomNormalFooterView {
    
    fileprivate func menuButtons() {
        
        let menuButton = ExpandingMenuButton(frame: CGRect(origin: CGPoint.zero, size: menuView.bounds.size), image: UIImage(named: "dy_send_gift_btn_big_pressed")!, rotatedImage: UIImage(named: "dy_send_gift_btn_big_pressed")!)
        menuButton.bottomViewColor = .white
        
        let item1 = ExpandingMenuItem(size: menuView.bounds.size, title: " ", image: UIImage(named: "dy_send_gift_btn_big_pressed")!, highlightedImage: UIImage(named: "dy_send_gift_btn_big_pressed")!, backgroundImage: UIImage(named: "dy_send_gift_btn_big_pressed"), backgroundHighlightedImage: UIImage(named: "dy_send_gift_btn_big_pressed")) { () -> Void in
            // Do some action
        }
        
        let item2 = ExpandingMenuItem(size: menuView.bounds.size, title: " ", image: UIImage(named: "dy_send_gift_btn_big_pressed")!, highlightedImage: UIImage(named: "dy_send_gift_btn_big_pressed")!, backgroundImage: UIImage(named: "dy_send_gift_btn_big_pressed"), backgroundHighlightedImage: UIImage(named: "dy_send_gift_btn_big_pressed")) { () -> Void in
            // Do some action
        }
        
        let item3 = ExpandingMenuItem(size: menuView.bounds.size, title: " ", image: UIImage(named: "dy_send_gift_btn_big_pressed")!, highlightedImage: UIImage(named: "dy_send_gift_btn_big_pressed")!, backgroundImage: UIImage(named: "dy_send_gift_btn_big_pressed"), backgroundHighlightedImage: UIImage(named: "dy_send_gift_btn_big_pressed")) { () -> Void in
            // Do some action
        }
        
        
        let item4 = ExpandingMenuItem(size: menuView.bounds.size, title: " ", image: UIImage(named: "dy_send_gift_btn_big_pressed")!, highlightedImage: UIImage(named: "dy_send_gift_btn_big_pressed")!, backgroundImage: UIImage(named: "dy_send_gift_btn_big_pressed"), backgroundHighlightedImage: UIImage(named: "dy_send_gift_btn_big_pressed")) { () -> Void in
            // Do some action
        }
        
        menuButton.addMenuItems([item1, item2, item3, item4])
        menuView.addSubview(menuButton)
    }
    
}
