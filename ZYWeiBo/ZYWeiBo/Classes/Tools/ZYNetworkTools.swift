//
//  NetworkTools.swift
//  ZYWeiBo
//
//  Created by ZhangYu on 2021/7/21.
//

import Foundation
import Alamofire

let baseDomain = ""
let basePicPath = ""

typealias ZYResponseSuccess = (_ response: AnyObject) -> Void
typealias ZYResponseFail = (_ error: AnyObject) -> Void
typealias ZYNetworkStatusBlock = (_ ZYNetworkStatus: Int32) -> Void

enum ZYNetworkStatus: Int32 {
    case unknown         = -1 //位置网络
    case notReachable    = 0  //网络无连接
    case wwan            = 1  //2,3,4,5G网络
    case wifi            = 2  //wifi网络
}
class ZYNetworkToos: NSObject{
    private let appKey = "3939621241"
    private let appSecret = "d7bd65ac4fedf7c89be974c11083efee"
    private let redirectUrl = "http://www.baidu.com"
    
    
    static let networkTools:ZYNetworkToos = {
        print("创建网络对象")
        return ZYNetworkToos()
    }()
    
    //TODO封装Session
    //默认超时时间
    private var zyTimeout: TimeInterval = 45
    
    ///当前网络状态
    private var zyNetworkStatus: ZYNetworkStatus = .wifi

    private var zyPrivateNetworkBaseUrl: String?
    /// 获取baseURL
    public func baseUrl() -> String? {
        let apiURL = URL(string: baseDomain)?.absoluteString
        return apiURL
    }
    
    ///中文路径encoding
    public func encodingURL(path: String) -> String {
        return path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
    
    
    ///拼接baseurl生成完整url
    public func absoluteUrlWithPath(path: String?) -> String {
        if path == nil
            || path?.count == 0 {
            return ""
        }
        if self.baseUrl() == nil
            || self.baseUrl()?.count == 0 {
            return path!
        }
        var absoluteUrl = path
        if !(path?.hasPrefix("http://"))!
            && !(path?.hasPrefix("https://"))! {
            if (self.baseUrl()?.hasPrefix("/"))! {
                if (path?.hasPrefix("/"))! {
                    var mutablePath = path
                    mutablePath?.remove(at: (path?.startIndex)!)
                    absoluteUrl = self.baseUrl()! + mutablePath!
                } else {
                    absoluteUrl = self.baseUrl()! + path!
                }
            } else {
                if (path?.hasPrefix("/"))! {
                    absoluteUrl = self.baseUrl()! + path!
                } else {
                    absoluteUrl = self.baseUrl()! + "/" + path!
                }
            }
        }
        return absoluteUrl!
    }
    
    /// 在url最后添加一部分,这里是添加的选择语言,可以根据需求修改.
    public func buildAPIString(path: String) -> String {
        if path.containsIgnoringCase(find: "http://")
            || path.containsIgnoringCase(find: "https://") {
            return path
        }
        let lang = "zh_CN"
        var str = ""
        if path.containsIgnoringCase(find: "?") {
            str = path + "&@lang=" + lang
        } else {
            str = path + "?@lang=" + lang
        }
        return str
    }
    
    ///核心方法
    public func requestWith(url: String,
                            httpMethod: Int32,
                            params: [String: Any]?,
                            success: @escaping ZYResponseSuccess,
                            error: @escaping ZYResponseFail) {
        if (self.baseUrl() == nil) {
            if URL(string: url) == nil {
                print("URLString无效")
                return
            }
        } else {
            if URL(string: "\(self.baseUrl()!)\(url)" ) == nil {
                print("URLString无效")
                return
            }
        }
        let encodingUrl = encodingURL(path: url)
        let absolute = absoluteUrlWithPath(path: encodingUrl)
        let lastUrl = buildAPIString(path: absolute)
        
        //TODO打印header进行调试.

        //Get
        if httpMethod == 0 {
            //无网络状态获取缓存
            if zyNetworkStatus.rawValue == ZYNetworkStatus.notReachable.rawValue
                || zyNetworkStatus.rawValue == ZYNetworkStatus.unknown.rawValue {
                //TODO 获取获取缓存数据

            }
            manageGet(url: lastUrl, params: params, success: success, error: error)
        } else {
//            managePost(url: lastUrl, params: params!, success: success, error: error)
        }
    }
    
    func manageGet(url: String,
                           params: [String: Any]?,
                           success: @escaping ZYResponseSuccess,
                           error: @escaping ZYResponseFail) {
        AF.request(url,
                        method: .get,
                        parameters: params,
                        encoding: URLEncoding.default,
                        headers: nil).responseJSON { (response) in
                            switch response.result {
                            case .success:
                                if let value = response.value as? [String: Any] {
                                    ///添加一些全部接口都有的一些状态判断
                                    success(value as AnyObject)
                                    //缓存数据
                                }
                            case .failure(let err):
                                error(err as AnyObject)
                                debugPrint(err)
                            }
        }
    }
    
    func managePost(url: String,
                           params: [String: Any]?,
                           success: @escaping ZYResponseSuccess,
                           error: @escaping ZYResponseFail) {
        AF.request(url,
                   method: .post,
                        parameters: params,
                        encoding: URLEncoding.default,
                        headers: nil).responseJSON { (response) in
                            switch response.result {
                            case .success:
                                if let value = response.value as? [String: Any] {
                                    ///添加一些全部接口都有的一些状态判断
                                    success(value as AnyObject)
                                    //缓存数据
                                }
                            case .failure(let err):
                                error(err as AnyObject)
                                debugPrint(err)
                            }
        }
    }
}

extension ZYNetworkToos {
    var OAuthURL:NSURL{
       let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(appKey)&redirect_uri=\(redirectUrl)"
        return NSURL(string: urlString)!
    }
}
