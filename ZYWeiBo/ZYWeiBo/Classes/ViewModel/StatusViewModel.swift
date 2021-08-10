//
//  StatusViewModel.swift
//  ZYWeiBo
//
//  Created by ZhangYu on 2021/8/5.
//

import UIKit

class StatusViewModel:CustomStringConvertible {
    //
    var status:Status
    
    //用户头像url
    var userProfileUrl: NSURL{
        return NSURL.init(string: status.user?.profile_image_url ?? "")!
    }
    
    //用户默认头像
    
    var userDefaultIconView: UIImage {
        return UIImage.init(named: "avatar_default_big")!
    }
    //用户会员图标
    
    var userMemberImage: UIImage?{
        if status.user!.mbrank > 0 && status.user!.mbrank < 7 {
            return UIImage.init(named: "common_icon_membership_level\(status.user!.mbrank)")
        }
        return nil
    }
    
    var userVipImage: UIImage?{
        switch (status.user!.verified_type - 1) {
        case 0:
            return UIImage.init(named: "avatar_vip")
        case 2,3,5:
            return UIImage.init(named: "avatar_enterprise_vip")
        case 220:
            return UIImage.init(named: "avatar_grassroot")
        default:
            return UIImage.init(named: "avatar_vip")
        }
    }
    
    var thumbnailUrls:[NSURL]?
    
    
    init(status:Status) {
        self.status = status
//        if let urls = status.retweeted_status?.pic_urls{
//            <#code#>
//        }
        
        if status.pic_urls!.count > 0 {
            thumbnailUrls = [NSURL]()
            for dic in status.pic_urls! {
                let url = NSURL.init(string: dic["thumbnail_pic"]!)
                thumbnailUrls?.append(url!)
            }
        }
    }
    
    var description: String {
        return status.description + "配图数组\(String(describing: thumbnailUrls))"
    }
}
