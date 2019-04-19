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
    lazy var anchorGroups : [AnchorGroupModel] = [AnchorGroupModel]()
    private lazy var bigDataGroup : AnchorGroupModel = AnchorGroupModel()
    private lazy var prettyDataGroup : AnchorGroupModel = AnchorGroupModel()

}


// MARK: 发送网络请求
extension RecommendViewModel {
    
    func requestData(finishCallback: @escaping () -> ()) {
        
        //0. 定义参数
        let parameters = ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime() as NSString]
        //0.1 创建 Group
        let dispatchGroup = DispatchGroup()
        
        //1. 请求第一部分推荐数据
        // 进入 DispatchGroup 组
        dispatchGroup.enter()
        // http://capi.douyucdn.cn/api/v1/getbigDataRoom?time=1555492932
        NetWorkTools.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : NSDate.getCurrentTime() as NSString]) { (result) in
            
            //1.1. 将 result 转成字典类型
            guard let resultDic = result as? [String : NSObject] else { return }
            
            //1.2. 根据 data 该 key，获取数组
            guard let dataArray = resultDic["data"] as? [[String : NSObject]] else { return }
            
            //1.3 遍历数组，获取字典，并将字典转成模型对象
            //1.3.1 设置组的属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            //1.3.2 获取主播数据
            for dict in dataArray {
                self.bigDataGroup.anchors.append(AnchorModel.init(dict: dict))
            }
            
            //1.4 离开组
            dispatchGroup.leave()
            print("请求到1")
            
        }
        
        
        //2. 请求第二部分颜值数据
        //进入组
        dispatchGroup.enter()
        // http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=4&offset=0&time=1555492932
        NetWorkTools.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            
            //2.1. 将 result 转成字典类型
            guard let resultDic = result as? [String : NSObject] else { return }
            
            //2.2. 根据 data 该 key，获取数组
            guard let dataArray = resultDic["data"] as? [[String : NSObject]] else { return }
            
            //2.3 遍历数组，获取字典，并将字典转成模型对象
            //2.3.1 设置组的属性
            self.prettyDataGroup.tag_name = "颜值"
            self.prettyDataGroup.icon_name = "home_header_phone"
            
            //2.3.2 获取主播数据
            for dict in dataArray {
                self.prettyDataGroup.anchors.append(AnchorModel.init(dict: dict))
            }
            
            //2.4 离开组
            dispatchGroup.leave()
            print("请求到2")
            
        }
        
        
        //3. 请求2-12部分游戏数据
        //进入组
        dispatchGroup.enter()
        // http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1555492932
        NetWorkTools.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
            
            //3.1. 将 result 转成字典类型
            guard let resultDic = result as? [String : NSObject] else { return }
            
            //3.2. 根据 data 该 key，获取数组
            guard let dataArray = resultDic["data"] as? [[String : NSObject]] else { return }
            
            //3.3. 遍历数组，获取字典，并将字典转成模型对象
            for dict in dataArray {
                let group = AnchorGroupModel(dict: dict)
                self.anchorGroups.append(group)
            }
            
            //3.4 离开组
            dispatchGroup.leave()
            print("请求到3")
            
        }
        
        
        //4. 所有数据都请求到，进行排序
        dispatchGroup.notify(queue: .main) {
            
            print("所有的数据都请求到")
            self.anchorGroups.insert(self.prettyDataGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishCallback()
        }
        
        
    }
    
}
