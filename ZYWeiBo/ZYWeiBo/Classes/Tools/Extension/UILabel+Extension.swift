//
//  UILabel+Extension.swift
//  ZYWeiBo
//
//  Created by ZhangYu on 2021/7/30.
//

import Foundation

import UIKit

extension UILabel {
    convenience init(title:String, fontSize:CGFloat=14, color:UIColor=UIColor.darkGray) {
        self.init()
        text = title
        textColor = color
        font = UIFont.systemFont(ofSize: fontSize)
        textAlignment = .center
    }
}
