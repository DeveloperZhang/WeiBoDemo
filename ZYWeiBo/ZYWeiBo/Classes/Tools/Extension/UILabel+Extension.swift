//
//  UILabel+Extension.swift
//  ZYWeiBo
//
//  Created by ZhangYu on 2021/7/30.
//

import Foundation

import UIKit

extension UILabel {
    convenience init(title:String, fontSize:CGFloat=14, color:UIColor=UIColor.darkGray, screenInset:CGFloat = 0) {
        self.init()
        text = title
        textColor = color
        font = UIFont.systemFont(ofSize: fontSize)
        textAlignment = .center
        numberOfLines = 0
        if screenInset == 0 {
            textAlignment = .center
        }else {
            preferredMaxLayoutWidth = UIScreen.main.bounds.width - 2 * screenInset
            textAlignment = .left
        }
    }
}
