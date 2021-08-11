//
//  StatusCell.swift
//  ZYWeiBo
//
//  Created by ZhangYu on 2021/8/5.
//

import UIKit

class StatusCell: UITableViewCell {
    
    private lazy var topView: StatusCellTopView = StatusCellTopView()
    lazy var contentLabel: UILabel = UILabel.init(title: "微博正文", fontSize: 15, color: UIColor.darkGray, screenInset: StatusCellMargin)
    lazy var bottomView: StatusCellBottomView = StatusCellBottomView()
    lazy var pictureView: StatusPictureView = StatusPictureView()

    
    var viewModel: StatusViewModel?{
        didSet{
            topView.viewModel = viewModel
            contentLabel.text = viewModel?.status.text
            pictureView.viewModel = viewModel
        }
    }

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func rowHeight(vm:StatusViewModel) -> CGFloat {
        viewModel = vm
        contentView.layoutIfNeeded()
        return bottomView.frame.maxY
    }

}

extension StatusCell {
    
    @objc func setupUI() {
        contentView.addSubview(topView)
        contentView.addSubview(contentLabel)
        contentView.addSubview(bottomView)
        contentView.addSubview(pictureView)
        
        topView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.height.equalTo(2 * StatusCellMargin + StatusCellIconWidth)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(StatusCellMargin)
            make.left.equalTo(contentView.snp.left).offset(StatusCellMargin)
        }
        

        
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(pictureView.snp.bottom).offset(StatusCellMargin)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.height.equalTo(44)
//            make.bottom.equalTo(contentView.snp.bottom)
        }
    }
}
