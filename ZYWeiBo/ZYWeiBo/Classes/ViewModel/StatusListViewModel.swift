//
//  StatusListViewModel.swift
//  ZYWeiBo
//
//  Created by ZhangYu on 2021/8/3.
//

import Foundation

class StatusListViewModel {
    lazy var statusList = [StatusViewModel]()
    var pulldownCount: Int?
    
    
    
    private func cacheSingleImage(dataList:[StatusViewModel], finished:@escaping (_ isSuccessed:Bool) -> ()) {
        let group = DispatchGroup.init()
        var dataLength = 0
        for vm in dataList {
            if vm.thumbnailUrls?.count != 1{
                continue
            }
            let url = vm.thumbnailUrls![0]
//            print("要缓存的url:\(url)")
            group.enter()
            SDWebImageManager.shared.loadImage(with: url as URL, options:[.retryFailed,.refreshCached], progress: nil) { image, _, error, _, _, _ in
                if let img = image,let data = img.pngData() {
                    dataLength += data.count
                        print(data.count)
                }
                group.leave()
            }
        }

        group.notify(queue: DispatchQueue.main) {
            print("缓存完成\(dataLength/1024) K")
            finished(true)
        }
    }
    
    func loadStatus(isPullup:Bool, finished:@escaping (_ isSuccessed:Bool) -> ()) {
        let since_id = isPullup ? 0 : (statusList.first?.status.id ?? 0)
        let max_id = isPullup ? (statusList.last?.status.id ?? 0) : 0
        
        ZYNetworkToos.sharedTools.loadStatus(since_id: since_id, max_id: max_id){ (result) in
            guard let array = (result["statuses"] as? [[String:AnyObject]]) else {
                print("数据格式错误")
                finished(false)
                return
            }
            var dataList =  [StatusViewModel]()
            for dic in array {
                dataList.append(StatusViewModel.init(status: Status(dic: dic)))
//                print("dic:\(dic.description)")
            }
            if max_id > 0 {
                self.statusList += dataList
            }else {
                self.pulldownCount = (since_id > 0) ? dataList.count : nil
                self.statusList = dataList + self.statusList
            }
            finished(true)
            self.cacheSingleImage(dataList: dataList) { isSuccessed in
                
            }
        } error: { (error) in
            if error.count < 0 {
                print("出错了")
                finished(false)
            }
        }
    }
}
