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
        self.webView.load(NSURLRequest(url: ZYNetworkToos.networkTools.OAuthURL as URL) as URLRequest)
        // Do any additional setup after loading the view.
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
