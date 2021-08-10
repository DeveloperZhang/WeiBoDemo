//
//  StatusCell.swift
//  ZYWeiBo
//
//  Created by ZhangYu on 2021/8/5.
//

import UIKit

class StatusCell: UITableViewCell {
    
    private lazy var topView: StatusCellTopView = StatusCellTopView()
    private lazy var contentLabel: UILabel = UILabel.init(title: "微博正文", fontSize: 15, color: UIColor.darkGray, screenInset: StatusCellMargin)
    private lazy var bottomView: StatusCellBottomView = StatusCellBottomView()
    
    private lazy var pictureView: StatusPictureView = StatusPictureView()
    


    
    var viewModel: StatusViewModel?{
        didSet{
            topView.viewModel = viewModel
            contentLabel.text = viewModel?.status.text
            pictureView.snp.updateConstraints { make in
                make.height.equalTo(Int(arc4random())%4 * 90)
            }
            pictureView.viewModel = viewModel
            pictureView.snp.updateConstraints { make in
                make.height.equalTo(pictureView.bounds.height)
                make.width.equalTo(pictureView.bounds.width)
            }
        }
    }
    
    lazy var rowHeights:CGFloat = {
//        print("计算缓存行高\(self.status.text)")
        let cell = StatusCell.init(style: .default, reuseIdentifier: StatusCellNormalId)
        return cell.rowHeight(vm: self.viewModel!)
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
    func rowHeight(vm:StatusViewModel) -> CGFloat {
        viewModel = vm
        contentView.layoutIfNeeded()
        return bottomView.frame.maxY
    }

}

extension StatusCell {
    
    private func setupUI() {
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
        
        
        pictureView.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(StatusCellMargin)
            make.left.equalTo(contentLabel.snp.left)
            make.width.equalTo(300)
            make.height.equalTo(90)
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
