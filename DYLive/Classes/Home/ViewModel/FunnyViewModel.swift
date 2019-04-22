//
//  FunnyViewModel.swift
//  DYLive
//
//  Created by Mr_Han on 2019/4/22.
//  Copyright © 2019 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

import UIKit

class FunnyViewModel : BaseViewModel {

}


extension FunnyViewModel {
    
    func loadFunnyData(finishCallback: @escaping () -> ()) {
        
        // http://capi.douyucdn.cn/api/v1/getColumnRoom/3?limit=30&offset=0
        loadAnchorData(isGroupData: true ,URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", parameters: nil, finishCallback: finishCallback)
        
    }
    
}
