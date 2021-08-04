//
//  ZYOAuthViewController.swift
//  ZYWeiBo
//
//  Created by ZhangYu on 2021/7/22.
//

import UIKit
import WebKit

class ZYOAuthViewController: UIViewController {
    


    private lazy var webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.load(NSURLRequest(url: ZYNetworkToos.sharedTools.OAuthURL as URL) as URLRequest)
        self.webView.navigationDelegate = self
    }
    
    @objc private func close() {
        dismiss(animated: true)
    }
    
    override func loadView() {
        view = webView
        title = "登录新浪微博"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(close))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", style: .plain, target: self, action: #selector(autoFill))
    }
    


    @objc func autoFill(){
        let js = "document.getElementById('loginName').value='18910265773';document.getElementById('loginPassword').value='a1111111'"
        webView.evaluateJavaScript(js)
        //获取html代码
//        let doc = "document.body.outerHTML";
//        webView.evaluateJavaScript(doc) { htmlStr, erro in
//            print(htmlStr!)
//        }
    }
    
}

extension ZYOAuthViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let urlFetch = navigationAction.request.url
//        let urlStr = "https://m.baidu.com/?code=96130c54f7595a3e8892c72b0c90e88a&from=844b&vit=fps"
//        let urlStr = "https://m.baidu.com/?code=96130c54f7595a3e8892c72b0c90e88a"
//        let urlFetch = URL.init(string: urlStr)
        print("url is:\(urlFetch?.absoluteString ?? "")")
        //https://m.baidu.com/?code=96130c54f7595a3e8892c72b0c90e88a&from=844b&vit=fps
        guard  let url =  urlFetch , url.host == "m.baidu.com" else {
            decisionHandler(WKNavigationActionPolicy.allow)
            return
        }
        
        guard let query = url.query, query.hasPrefix("code=") else {
            print("取消授权")
            return
        }
        
        var code = ""
        if query.contains("&") {
            guard let endIndex = query.firstIndex(of: "&"), query.contains("&") else {
                print("无后续参数")
                return
            }
            code = String(query["code=".endIndex..<endIndex])
            print("授权码是\(code)")
        }else {
            code = String(query["code=".endIndex..<query.endIndex])
            print("授权码是\(code)")
        }
        UserAccountViewModel.sharedUserAccount.loadAccessToken(code: code) { (result) in
            if result is NSNull {
                return
            }
            let account = UserAccountViewModel.sharedUserAccount.account
            print("account is \(account!)")
            
            self.dismiss(animated: false) {
                NotificationCenter.default.post(name: Notification.Name(ZYSwitchRootViewControllerNotification), object: "welcome")
            }
            
        } error: { _ in
            
        }


        decisionHandler(WKNavigationActionPolicy.cancel)
        
    }
    
    private func loadUserInfo(account:UserAccount) {
        let userVM = UserAccountViewModel.sharedUserAccount
        userVM.loadUserInfo(uid: account.uid!, accessToken: account.access_token!) { result in
            guard let dic = result as? [String: AnyObject] else {
                print("格式错误")
                return
            }
            account.screen_name = dic["screen_name"] as? String
            account.avatar_large = dic["avatar_large"] as? String
            print(account)
        } error: { _ in
            print("加载用户出错")
        }

    }
    
}
