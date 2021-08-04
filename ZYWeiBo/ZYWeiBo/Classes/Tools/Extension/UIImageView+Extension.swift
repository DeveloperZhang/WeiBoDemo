//
//  UIImageView+Extension.swift
//  ZYWeiBo
//
//  Created by ZhangYu on 2021/7/30.
//

import Foundation

import UIKit

extension UIImageView {
    convenience init(imageName:String) {
        self.init(image: UIImage(named: imageName))
    }
}
