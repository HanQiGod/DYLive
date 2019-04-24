//
//  GiftView.swift
//  DYLive
//
//  Created by Mr_Han on 2019/4/24.
//  Copyright © 2019 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

import UIKit

private let kGiftViewCellID = "kGiftViewCellID"

private let kGiftViewMargin : CGFloat = 1.0
private let kGiftViewCellW : CGFloat = (kScreenW - kGiftViewMargin * 3) / 4
private let kGiftViewCellH : CGFloat = (kGiftViewH - kGiftViewMargin) / 2

class GiftView: UIView {
    
    var roomShowBottomView : RoomShowBottomView?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 注册 cell
        collectionView.register(UINib(nibName: "GiftViewCell", bundle: nil), forCellWithReuseIdentifier: kGiftViewCellID)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: kGiftViewCellW, height: kGiftViewCellH)
        
    }
    
}


// MARK: 创建类方法
extension GiftView {
    
    class func giftView() -> GiftView {
        return Bundle.main.loadNibNamed("GiftView", owner: nil, options: nil)?.first as! GiftView
    }
    
}

// MARK: 遵守 UICollectionViewDataSource & UICollectionViewDelegate 协议
extension GiftView : UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGiftViewCellID, for: indexPath) as! GiftViewCell
        
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        roomShowBottomView?.giftViewHidden()
        
    }
    
}
