//
//  StatusNormalCell.swift
//  ZYWeiBo
//
//  Created by ZhangYu on 2021/8/10.
//

import UIKit

class StatusNormalCell: StatusCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override var viewModel: StatusViewModel?{
        didSet{
//            pictureView.snp.updateConstraints { make in
//                let offset = viewModel?.thumbnailUrls?.count == 0 ? 0 : StatusCellMargin
//                make.top.equalTo(contentLabel.snp.bottom).offset(offset)
//            }
//            pictureView.viewModel = viewModel
//            pictureView.snp.updateConstraints { make in
//                make.height.equalTo(pictureView.bounds.height)
//                make.width.equalTo(pictureView.bounds.width)
//            }
//            bottomView.snp.updateConstraints { make in
//                make.top.equalTo(pictureView.snp.bottom).offset(StatusCellMargin)
//            }
        }
    }
    
    override func setupUI() {
        super.setupUI()
        
//        pictureView.snp.makeConstraints { make in
//            make.top.equalTo(contentLabel.snp.bottom).offset(StatusCellMargin)
//            make.left.equalTo(contentLabel.snp.left)
//            make.width.equalTo(300)
//            make.height.equalTo(90)
//        }
    }

}
