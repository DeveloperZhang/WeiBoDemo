//
//  UIButton+Extension.swift
//  ZYWeiBo
//
//  Created by ZhangYu on 2021/7/16.
//

import UIKit

extension UIButton {
    convenience init(imageName:String, backImageName:String?) {
        self.init()
        setImage(UIImage(named: imageName), for: .normal)
        setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        setBackgroundImage(UIImage(named: backImageName!), for: .normal)
        setBackgroundImage(UIImage(named: backImageName! + "_highlighted"), for: .normal)
        sizeToFit()
    }
}
