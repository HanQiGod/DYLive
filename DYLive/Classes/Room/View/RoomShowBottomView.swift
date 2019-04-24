//
//  RoomShowBottomView.swift
//  DYLive
//
//  Created by Mr_Han on 2019/4/23.
//  Copyright © 2019 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

import UIKit

let kGiftViewH : CGFloat = kScreenH / 4
private let kChatShowViewW : CGFloat = kScreenW * 3 / 4
private let kChatShowViewH : CGFloat = kChatShowViewW * 2 / 3


class RoomShowBottomView: UIView {
    
    @IBOutlet weak var particleBtn: UIButton!
    
    // MARK: 定义属性
    var roomShowVc : UIViewController?
    
    // MARK: 懒加载属性
    fileprivate lazy var giftView : GiftView = {
        
        let giftView = GiftView.giftView()
        
        giftView.frame = CGRect(x: 0, y: kScreenH, width: kScreenW, height: kGiftViewH)
        
        return giftView
        
    }()
    fileprivate lazy var chatShowView : ChatShowView = {
        
        let chatShowView = ChatShowView.chatShowView()
        
        chatShowView.frame = CGRect(x: 0, y: kScreenH-kChatShowViewH-self.bounds.height, width: kChatShowViewW, height: kChatShowViewH)
        
        return chatShowView
        
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        giftView.roomShowBottomView = self
        roomShowVc?.view.insertSubview(giftView, at: 2)
        roomShowVc?.view.insertSubview(chatShowView, at: 2)
        addParticleEffect(particleBtn.center)
        
    }

}

// MARK: 创建类方法
extension RoomShowBottomView {
    
    class func roomShowBottomView() -> RoomShowBottomView {
        return Bundle.main.loadNibNamed("RoomShowBottomView", owner: nil, options: nil)?.first as! RoomShowBottomView
    }
    
}


// MARK: 监听点击事件
extension RoomShowBottomView {
    
    @IBAction func roomShowBottomBtnsAction(_ sender: UIButton) {
        
        switch sender.tag {
        case 110:// 聊天

            break
        case 111:// 分享

            break
        case 112:// 礼物
            giftViewShow()
            break
        case 113:// 粒子动画
            
            break
        default:
            break
        }
        
    }
    
}


// MARK: 显示&隐藏 View
extension RoomShowBottomView {
    
    // giftView
    func giftViewShow() {
        UIView.animate(withDuration: 0.3) {
            self.giftView.frame.origin.y = kScreenH - kGiftViewH
            self.isHidden = true
        }
    }
    
    func giftViewHidden() {
        UIView.animate(withDuration: 0.3) {
            self.giftView.frame.origin.y = kScreenH
            self.isHidden = false
        }
    }
    
    // chatShowView

}


// MARK: 粒子动画
extension RoomShowBottomView {
    
    func addParticleEffect(_ point : CGPoint)  {
        
        // 1.创建发射器
        let emitter = CAEmitterLayer()
        // 2.发射器位置
        emitter.emitterPosition = point
        // 3.开启三维效果
        emitter.preservesDepth = true
        var cells = [CAEmitterCell]()
        for i in 0..<3 {
            // 4.设置 Cell(对应其中一个粒子)
            // 4.0.创建粒子
            let cell = CAEmitterCell()
            // 4.1.每秒发射粒子数
            cell.birthRate = Float(arc4random_uniform(3)) + 3
            // 4.2.粒子存活时间
            cell.lifetime = 5
            cell.lifetimeRange = 2.5
            // 4.3.缩放比例
            cell.scale = 0.8
            cell.scaleRange = 0.4
            // 4.4.粒子发射方向
            cell.emissionLongitude = CGFloat(-Double.pi / 2)
            cell.emissionRange = CGFloat(Double.pi / 4 * 0.6)
            // 4.5.粒子速度
            cell.velocity = 100
            cell.velocityRange = 50
            // 4.6.旋转速度
            cell.spin = CGFloat(Double.pi / 2)
            // 4.7.粒子内容
            cell.contents = UIImage(named: "par_\(i)")?.cgImage
            cells.append(cell)
        }
        // 5.将粒子添加到发射器中
        emitter.emitterCells = cells
        self.layer.addSublayer(emitter)
    }
    
    func removeParticleEffect() {
        //方式1: 常规遍历
        //        for layer in view.layer.sublayers! {
        //            if layer.isKind(of: CAEmitterLayer.self) {
        //                layer.removeFromSuperlayer()
        //            }
        //        }
        //方式2: 映射
        self.layer.sublayers?.filter({ $0.isKind(of: CAEmitterLayer.self)}).last?.removeFromSuperlayer()
    }
    
}
