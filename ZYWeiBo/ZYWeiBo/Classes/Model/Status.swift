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
    
    var pic_urls:[[String:String]]?
    
    //被转发的微博字段
    var retweeted_status:Status?
    
    
    init(dic:[String: AnyObject]) {
        super.init()
        setValuesForKeys(dic)
    }
    
    
    override var description: String {
        let keys = ["id","text","created_at","source","user","pic_urls","retweeted_status"]
        return dictionaryWithValues(forKeys: keys).description
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "user" {
            if let dict = value as?[String:AnyObject] {
                user = User(dict: dict)
            }
            return
        } else if key == "retweeted_status" {
            if let dict = value as?[String:AnyObject] {
                retweeted_status = Status(dic: dict)
            }
            return
        }
        super.setValue(value, forKey: key)
    }


    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

}
