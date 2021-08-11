//
//  StatusNormalCell.swift
//  ZYWeiBo
//
//  Created by ZhangYu on 2021/8/10.
//

import UIKit

class StatusNormalCell: StatusCell {
    
    override var viewModel: StatusViewModel?{
        didSet{
            pictureView.snp.updateConstraints { make in
                make.height.equalTo(pictureView.bounds.height)
                make.width.equalTo(pictureView.bounds.width)
            }
        }
    }
    
    override func setupUI() {
        super.setupUI()
        
        pictureView.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(StatusCellMargin)
            make.left.equalTo(contentLabel.snp.left)
            make.width.equalTo(300)
            make.height.equalTo(90)
        }
    }

}
