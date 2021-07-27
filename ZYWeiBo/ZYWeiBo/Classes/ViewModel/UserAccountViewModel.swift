//
//  UserAccountViewModel.swift
//  ZYWeiBo
//
//  Created by ZhangYu on 2021/7/24.
//

import UIKit

class UserAccountViewModel: NSObject {
    static let sharedUserAccount:UserAccountViewModel = {
        return UserAccountViewModel()
    }()
    
    var account:UserAccount?
    private var accountPath:String{
        let path = NSSearchPathForDirectoriesInDomains(.userDirectory, .userDomainMask, true).last!
        return (path as NSString).strings(byAppendingPaths: ["account.plist"]).last!
    }
    
    private var isExpired:Bool {
        // 其中 starStr， stopStr 为字符串类型，结构类似“2020-01-01”
        let intervalNow = NSDate().timeIntervalSince1970
        let intervalExpires = account!.expiresDate!.timeIntervalSince1970
        if intervalNow < intervalExpires {
            print("已过期")
            return false
        }
        return true
    }
    
    var accessToken:String?{
        if !isExpired{
            return account?.access_token
        }
        print("token已经过期")
        return nil
    }
    
    private var tokenDict:[String:String]?{
        if let token = UserAccountViewModel.sharedUserAccount.account?.access_token{
                return ["access_token":token]
        }
        return nil
    }
    
    private override init() {
        super.init()
        guard let data = UserDefaults.standard.object(forKey: "user") else {
            return
        }
        
       account =  try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data as! Data) as? UserAccount
        if self.isExpired {
            print("已经过期")
            account = nil
        }
        print("account is:\(account!)")
        
    }
    
    var userLogon:Bool {
        return account?.access_token != nil && !isExpired
    }
    
    func loadUserInfo(uid:String, accessToken:String, success:@escaping ZYResponseSuccess, error:@escaping ZYResponseSuccess) {
        let urlString = "https://api.weibo.com/2/users/show.json"
//        let params1 = ["uid":uid, "access_token":accessToken]
        
        guard var params:[String : String] = tokenDict else {
            error(NSError(domain: "cn.vicent.error", code: -1001, userInfo: ["message":"token为空"]))
            return
        }
        params["uid"] = uid
        ZYNetworkToos.networkTools.requestWith(url: urlString, httpMethod: .GET, params: params) { (result) -> Void in
            success(result)
        
        } error: { (err) -> Void in
            error(err)
        }
    }
    
    
    func loadAccessToken(code:String, success: @escaping ZYResponseSuccess,
                         error: @escaping ZYResponseFail) {
        let urlString = "https://api.weibo.com/oauth2/access_token"
        let params = ["client_id":ZYConst.sharedConst.appKey,"client_secret":ZYConst.sharedConst.appSecret,"grant_type":"authorization_code",
                      "code":code,"redirect_uri":ZYConst.sharedConst.redirectUrl]
        ZYNetworkToos.networkTools.requestWith(url: urlString, httpMethod: .POST, params: params) { (result) -> Void in
            self.account = UserAccount.init(dic: result as! [String:AnyObject])
            self.loadUserInfo(uid: (self.account?.uid!)!, accessToken: (self.account?.access_token)!) { (result1) in
                let dic = result1 as! [String:AnyObject]
                self.account?.screen_name = dic["screen_name"] as? String
                self.account?.avatar_large = dic["avatar_large"] as? String
                self.account?.saveUserAccount()
                success(result1)
            } error: { (err) in
                error(err)
            }
        } error: { (err) -> Void in
            error(err)
        }

    }
    
    
    
}
