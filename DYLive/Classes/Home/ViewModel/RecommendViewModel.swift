//
//  RecommendViewModel.swift
//  DYLive
//
//  Created by Mr_Han on 2019/4/17.
//  Copyright © 2019 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

import UIKit

class RecommendViewModel {
    
    // MARK: 懒加载属性
    private lazy var anchorGroups : [AnchorGroupModel] = [AnchorGroupModel]()

}


// MARK: 发送网络请求
extension RecommendViewModel {
    
    func requestData() {
        
        //1. 请求第一部分推荐数据
        
        //2. 请求第二部分颜值数据
        
        //3. 请求后面部分游戏数据
        // http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1555492932
        NetWorkTools.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime() as NSString]) { (result) in
            
            //1. 将 result 转成字典类型
            guard let resultDic = result as? [String : NSObject] else { return }
            
            //2. 根据 data 该 key，获取数组
            guard let dataArray = resultDic["data"] as? [[String : NSObject]] else { return }
            
            //3. 遍历数组，获取字典，并将字典转成模型对象
            for dict in dataArray {
                let group = AnchorGroupModel(dict: dict)
                self.anchorGroups.append(group)
            }
            
            for group in self.anchorGroups {
                print("----------")
                for anchor in group.anchors {
                    print(anchor.nickname)
                }
            }
            
        }
        
        
    }
    
}
