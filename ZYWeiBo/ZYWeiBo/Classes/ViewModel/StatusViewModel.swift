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
    
    
    var retweetedText:String?{
        guard let s = status.retweeted_status else {
            return nil
        }
        return "@" + (s.user?.screen_name ?? " ") + " : " + (s.text ?? " ")
    }
    
    var cellId:String {
        return status.retweeted_status != nil ? StatusCellRetweetedId : StatusCellNormalId
    }
    
    lazy var rowHeight:CGFloat = {
        var cell:StatusCell
        if self.status.retweeted_status != nil {
            cell = StatusRetweetedCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: StatusCellRetweetedId)
        }else {
            cell = StatusNormalCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: StatusCellNormalId)

        }
        return cell.rowHeight(vm: self)
    }()
    
    
    init(status:Status) {
        self.status = status
        if let urls = status.retweeted_status?.pic_urls {
            thumbnailUrls = [NSURL]()
            for dic in urls {
                let url = NSURL.init(string: dic["thumbnail_pic"]!)
                thumbnailUrls?.append(url!)
            }
        }else {
            if let urls = status.pic_urls {
                thumbnailUrls = [NSURL]()
                for dic in urls {
                    let url = NSURL.init(string: dic["thumbnail_pic"]!)
                    thumbnailUrls?.append(url!)
                }
            }
            
        }
    }
    
    var description: String {
        return status.description + "配图数组\(String(describing: thumbnailUrls))"
    }
}
