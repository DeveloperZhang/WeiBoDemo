//
//  StatusCellTopView.swift
//  ZYWeiBo
//
//  Created by ZhangYu on 2021/8/5.
//

import UIKit

class StatusCellTopView: UIView {
    
    var viewModel: StatusViewModel?{
        didSet{
            nameLabel.text = viewModel?.status.user?.screen_name
            iconView.sd_setImage(with: viewModel!.userProfileUrl as URL, placeholderImage: viewModel?.userDefaultIconView)
            memberIconView.image = viewModel?.userMemberImage
            vipIconView.image = viewModel?.userVipImage
            timeLabel.text = "刚刚"
            sourceLabel.text = "Vicent微博"
        }
    }
    
    private lazy var iconView: UIImageView = UIImageView.init(imageName: "avatar_default_big")
    private lazy var nameLabel: UILabel = UILabel.init(title: "王老五", fontSize: 14)
    private lazy var memberIconView: UIImageView = UIImageView.init(imageName: "common_icon_membership_level")
    private lazy var vipIconView: UIImageView = UIImageView.init(imageName: "avatar_vip")
    private lazy var timeLabel: UILabel = UILabel.init(title: "现在", fontSize: 11, color: UIColor.orange)
    private lazy var sourceLabel: UILabel = UILabel.init(title: "来源", fontSize: 11)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StatusCellTopView {
    private func setupUI() {
        addSubview(iconView)
        addSubview(nameLabel)
        addSubview(memberIconView)
        addSubview(vipIconView)
        addSubview(timeLabel)
        addSubview(sourceLabel)
        
        let sepView = UIView()
        sepView.backgroundColor = UIColor.lightGray
        addSubview(sepView)
        
        sepView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.height.equalTo(StatusCellMargin)
        }
        
        iconView.snp.makeConstraints { make in
            make.top.equalTo(sepView.snp.bottom).offset(StatusCellMargin)
            make.left.equalTo(self.snp.left).offset(StatusCellMargin)
            make.width.equalTo(StatusCellIconWidth)
            make.height.equalTo(StatusCellIconWidth)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(iconView.snp.top)
            make.left.equalTo(iconView.snp.right).offset(StatusCellMargin)
        }
        
        memberIconView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.top)
            make.left.equalTo(nameLabel.snp.right).offset(StatusCellMargin)
        }
        
        vipIconView.snp.makeConstraints { make in
            make.centerX.equalTo(iconView.snp.right)
            make.centerY.equalTo(iconView.snp.bottom)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.bottom.equalTo(iconView.snp.bottom)
            make.left.equalTo(iconView.snp.right).offset(StatusCellMargin)
        }
        
        sourceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(timeLabel.snp.bottom)
            make.left.equalTo(timeLabel.snp.right).offset(StatusCellMargin)
        }

    }
}
