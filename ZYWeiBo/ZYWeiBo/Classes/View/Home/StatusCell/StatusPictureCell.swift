//
//  StatusPictureCell.swift
//  ZYWeiBo
//
//  Created by ZhangYu on 2021/8/10.
//

import UIKit

class StatusPictureCell: UICollectionViewCell {
    private lazy var iconView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var gifIconView:UIImageView = UIImageView.init(imageName: "timeline_image_gif")
    
    
    var imageURL: NSURL?{
        didSet{
            iconView.sd_setImage(with: imageURL as URL?, placeholderImage: nil, options: [.retryFailed, .refreshCached])
            let ext = ((imageURL?.absoluteString! ?? "") as NSString).pathExtension.lowercased()
            gifIconView.isHidden = (ext != "gif")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(iconView)
        contentView.addSubview(gifIconView)
        
        iconView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.snp.edges)
        }
        
        gifIconView.snp.makeConstraints { make in
            make.right.equalTo(iconView.snp.right)
            make.bottom.equalTo(iconView.snp.bottom)
        }
    }
    
}


