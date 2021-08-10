//
//  StatusRetweetedCell.swift
//  ZYWeiBo
//
//  Created by ZhangYu on 2021/8/10.
//

import UIKit

class StatusRetweetedCell: StatusCell {
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.init(white: 0.95, alpha: 1.0)
        return button
    }()
    
    private lazy var reteetedLabel:UILabel = UILabel.init(title: "转发微博", fontSize: 14, color: UIColor.darkGray, screenInset: StatusCellMargin)
    

    override var viewModel: StatusViewModel?{
        didSet {
            let reteetedLabelString = viewModel?.retweetedText
            print("reteetedLabelString is \(String(describing: reteetedLabelString))")
            reteetedLabel.text = reteetedLabelString!
            
//            pictureView.snp.makeConstraints { make in
//                let offset = viewModel?.thumbnailUrls?.count == 0 ? 0 : StatusCellMargin
//                make.top.equalTo(reteetedLabel.snp.bottom).offset(offset)
//            }
//            self.layoutSubviews()
//            pictureView.snp.updateConstraints { make in
//                make.height.equalTo(pictureView.bounds.height)
//                make.width.equalTo(pictureView.bounds.width)
//            }
//
//            bottomView.snp.updateConstraints { make in
//                make.top.equalTo(pictureView.snp.bottom).offset(StatusCellMargin)
//            }        
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setupUI() {
        super.setupUI()
        contentView.insertSubview(backButton, belowSubview: pictureView)
        contentView.insertSubview(reteetedLabel, aboveSubview: backButton)
        
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(StatusCellMargin)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.bottom.equalTo(bottomView.snp.top)
        }
        
        reteetedLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.top).offset(StatusCellMargin)
            make.left.equalTo(backButton.snp.left).offset(StatusCellMargin)
        }
        
//        pictureView.snp.makeConstraints { make in
//            make.top.equalTo(reteetedLabel.snp.bottom).offset(StatusCellMargin)
//            make.left.equalTo(reteetedLabel.snp.left)
//            make.width.equalTo(300)
//            make.height.equalTo(90)
//        }
//
    }

}
