//
//  User.swift
//  ZYWeiBo
//
//  Created by ZhangYu on 2021/8/4.
//

import UIKit

@objcMembers
class User: NSObject {
    //用户id
    var id:Int = 0
    //用户昵称
    var screen_name:String?
    //用户头像地址(中图),50*50
    var profile_image_url:String?
    //认证类型,-1:没有认证,0:认证用户,2,3,5:企业认证,220:达人
    var verified_type:Int = 0
    //会员等级0-6
    var mbrank:Int = 0
    
    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override var description: String{
        let keys = ["id", "screen_name", "profile_image_url", "verified_type", "mbrank"]
        return dictionaryWithValues(forKeys: keys).description
    }
    
    
    
    
    
}
