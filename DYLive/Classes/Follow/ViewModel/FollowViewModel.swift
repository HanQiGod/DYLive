//
//  FollowViewModel.swift
//  DYLive
//
//  Created by Mr_Han on 2019/4/25.
//  Copyright © 2019 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

import UIKit

class FollowViewModel: BaseViewModel {
    
}


// MARK: 发送请求
extension FollowViewModel {
    
    func loadFollowData(finishCallback: @escaping () -> ()) {
                
        NetWorkTools.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time":NSDate.getCurrentTime()]) { (result) in

            //1. 获取字典数据
            guard let resultDict = result as? [String : Any] else {return}

            //2. 获取dataArray
            guard let dataArray = resultDict["data"] as? [[String : Any]] else {return}

            //3.1 创建组
            let group = AnchorGroupModel()
            group.tag_name = "推荐直播"
            group.icon_name = "Img_orange"
            //3.2 遍历 dataArray 所有的字典
            for dict in dataArray {
                group.anchors.append(AnchorModel(dict: dict))
            }
            //3.3 将 group 添加到 anchorGroups 里面
            self.anchorGroups.append(group)
            
            //4. 回调
            finishCallback()

        }
        
    }
    
}
