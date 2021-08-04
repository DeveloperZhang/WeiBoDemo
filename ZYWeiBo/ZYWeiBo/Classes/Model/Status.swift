//
//  Status.swift
//  ZYWeiBo
//
//  Created by ZhangYu on 2021/8/3.
//

import Foundation

@objcMembers
class Status: NSObject {
    var id:Int = 0
    //微博信息内容
    var text:String?
    //微博创建时间
    var created_at:String?
    //微博来源
    var source:String?
    //用户模型
    var user:User?
    
    
    init(dic:[String: AnyObject]) {
        super.init()
        setValuesForKeys(dic)
    }
    
    
    override var description: String {
        let keys = ["id","text","created_at","source","user"]
        return dictionaryWithValues(forKeys: keys).description
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "user" {
            if let dict = value as?[String:AnyObject] {
                user = User(dict: dict)
            }
            return
        }
        super.setValue(value, forKey: key)
    }


    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

}
