//
//  NetWorkTools.swift
//  Alamofire的测试
//
//  Created by Mr_Han on 2019/4/17.
//  Copyright © 2019 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class NetWorkTools {
    
    class func requestData(type: MethodType, URLString: String, parameters: [String : NSString]? = nil, finishCallback: @escaping (_ result: AnyObject) -> ()) {
        
        //1. 获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        //2. 发送请求
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            
            //3. 获取数据
            guard let result = response.result.value else {
                print(response.result.error)
                return
            }
            
            //4. 将结果返回
            finishCallback(result as AnyObject)
        }
        
    }

}
