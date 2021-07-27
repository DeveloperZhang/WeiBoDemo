//
//  ZYConst.swift
//  ZYWeiBo
//
//  Created by ZhangYu on 2021/7/22.
//

import UIKit

class ZYConst: NSObject {
    let appKey = "3939621241"
    let appSecret = "d7bd65ac4fedf7c89be974c11083efee"
    let redirectUrl = "http://www.baidu.com"
    
    
    static let sharedConst:ZYConst = {
        print("创建常量对象")
        return ZYConst()
    }()
    

}
