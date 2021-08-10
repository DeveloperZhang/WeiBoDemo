//
//  ZYConst.swift
//  ZYWeiBo
//
//  Created by ZhangYu on 2021/7/22.
//

import UIKit

let StatusCellMargin: CGFloat = 12
let StatusCellIconWidth: CGFloat = 35

class ZYConst: NSObject {
    let appKey = "3939621241"
    let appSecret = "c6f5e8483f950c224f3369b3db1e7398"
    let redirectUrl = "http://www.baidu.com"
    
    
    static let sharedConst:ZYConst = {
        print("创建常量对象")
        return ZYConst()
    }()
    

}
