//
//  UserAccount.swift
//  ZYWeiBo
//
//  Created by ZhangYu on 2021/7/24.
//

import UIKit

@objcMembers
class UserAccount: NSObject, NSCoding, NSSecureCoding {
    static var supportsSecureCoding: Bool { return true } // 需要添加这个静态属性
    
    var access_token:String?
    var uid:String?
    var expires_in:TimeInterval = 0
//    {
//        didSet {
//            expiresDate = expires_in * 1000
//        }
//    }
//    var expiresDate:TimeInterval?
    var screen_name:String?
    var avatar_large:String?
    

    func encode(with coder: NSCoder) {
        coder.encode(access_token, forKey: "access_token")
        coder.encode(expires_in, forKey: "expires_in")
        coder.encode(uid, forKey: "uid")
        coder.encode(screen_name, forKey: "screen_name")
        coder.encode(avatar_large, forKey: "avatar_large")
    }

    
    required init?(coder: NSCoder) {
        access_token = coder.decodeObject(forKey: "access_token") as? String
        uid = coder.decodeObject(forKey: "uid") as? String
        expires_in = coder.decodeDouble(forKey: "expires_in")
        screen_name = coder.decodeObject(forKey: "screen_name") as? String
        avatar_large = coder.decodeObject(forKey: "avatar_large") as? String
        
    }
    
    func saveUserAccount() {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
        print("沙盒路径为：\(path)")
//        let path1 = (path as NSString).strings(byAppendingPaths: ["account.plist"])
//        print(path1)
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: true)
            UserDefaults.standard.setValue(data, forKey: "user")
            UserDefaults.standard.synchronize()
            guard let data = UserDefaults.standard.object(forKey: "user") else {
                return
            }
            
           let account =  try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data as! Data) as? UserAccount
           print("account is:\(account!)")
            
        } catch let error{
            print(error)
        }
        
    }
    init(dic:[String:AnyObject]) {
        super.init()
        setValuesForKeys(dic)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override var description: String{
        let keys = ["access_token","expires_in","uid","screen_name","avatar_large"]
        return dictionaryWithValues(forKeys: keys).description
    }
}
