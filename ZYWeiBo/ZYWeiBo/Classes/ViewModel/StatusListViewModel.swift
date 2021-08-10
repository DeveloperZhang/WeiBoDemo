//
//  StatusListViewModel.swift
//  ZYWeiBo
//
//  Created by ZhangYu on 2021/8/3.
//

import Foundation

class StatusListViewModel {
    lazy var statusList = [StatusViewModel]()
    
    func loadStatus(finished:@escaping (_ isSuccessed:Bool) -> ()) {
        ZYNetworkToos.sharedTools.loadStatus { (result) in
            guard let array = (result["statuses"] as? [[String:AnyObject]]) else {
                print("数据格式错误")
                finished(false)
                return
            }
            var dataList =  [StatusViewModel]()
            for dic in array {
                dataList.append(StatusViewModel.init(status: Status(dic: dic)))
                print("dic:\(dic.description)")
            }
            self.statusList = dataList
            finished(true)
        } error: { (error) in
            if error.count < 0 {
                print("出错了")
                finished(false)
            }
        }
    }
}
