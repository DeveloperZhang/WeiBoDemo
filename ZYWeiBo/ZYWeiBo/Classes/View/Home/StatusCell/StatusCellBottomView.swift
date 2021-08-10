//
//  StatusCellBottomView.swift
//  ZYWeiBo
//
//  Created by ZhangYu on 2021/8/5.
//

import UIKit

class StatusCellBottomView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    private lazy var retweetedButton: UIButton = UIButton.init(title: "转发", fontSize: 12, color: UIColor.darkGray, backImageName: "timeline_icon_retweet")
    private lazy var commentButton: UIButton = UIButton.init(title: "评论", fontSize: 12, color: UIColor.darkGray, backImageName: "timeline_icon_comment")
    private lazy var likeButton: UIButton = UIButton.init(title: "赞", fontSize: 12, color: .darkGray, backImageName: "timeline_icon_unlike")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }


}

extension StatusCellBottomView {
    private func setupUI() {
        backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
        
        addSubview(retweetedButton)
        addSubview(commentButton)
        addSubview(likeButton)
        
        retweetedButton.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left)
            make.bottom.equalTo(self.snp.bottom)
        }
        
        commentButton.snp.makeConstraints { make in
            make.top.equalTo(retweetedButton.snp.top)
            make.left.equalTo(retweetedButton.snp.right)
            make.width.equalTo(retweetedButton.snp.width)
            make.height.equalTo(retweetedButton.snp.height)
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(commentButton.snp.top)
            make.left.equalTo(commentButton.snp.right)
            make.width.equalTo(commentButton.snp.width)
            make.height.equalTo(commentButton.snp.height)
            make.right.equalTo(self.snp.right)
        }
        
        let sep1 = sepView()
        let sep2 = sepView()
        
        addSubview(sep1)
        addSubview(sep2)
        
        let w = 1
        let scale = 0.4
        
        sep1.snp.makeConstraints { make in
            make.left.equalTo(retweetedButton.snp.right)
            make.centerY.equalTo(retweetedButton.snp.centerY)
            make.width.equalTo(w)
            make.height.equalTo(retweetedButton.snp.height).multipliedBy(scale)
        }
        
        sep2.snp.makeConstraints { make in
            make.left.equalTo(commentButton.snp.right)
            make.centerY.equalTo(retweetedButton.snp.centerY)
            make.width.equalTo(w)
            make.height.equalTo(retweetedButton.snp.height).multipliedBy(scale)
        }
    }
    
    private func sepView() -> UIView {
        let v = UIView()
        v.backgroundColor = UIColor.darkGray
        return v
    }
}
