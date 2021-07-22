//
//  VisitorView.swift
//  ZYWeiBo
//
//  Created by ZhangYu on 2021/7/19.
//

import UIKit
import SnapKit

class VisitorView: UIView {
    
    private lazy var iconView:UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    private lazy var homeIconView:UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    private lazy var messageLabel:UILabel = {
        let label = UILabel()
        label.text = "关注一些人,回这里看看有什么惊喜"
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    lazy var registerButton:UIButton = {
        let button = UIButton()
        button.setTitle("注册", for: .normal)
        button.setTitleColor(UIColor.orange, for: .normal)
        button.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: .normal)
        return button
    }()
    lazy var loginButton:UIButton = {
        let button = UIButton()
        button.setTitle("登录", for: .normal)
        button.setTitleColor(UIColor.orange, for: .normal)
        button.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: .normal)
        return button
    }()
    
    private lazy var maskIconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init (coder:) has not been implemented")
    }

}

extension VisitorView {
    fileprivate func setupSubViewsLayoutWithSnapKit() {
        iconView.snp.makeConstraints { (make) ->  Void in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY).offset(-60)
        }
        
        homeIconView.snp.makeConstraints{(make) ->  Void in
            make.center.equalTo(iconView.snp.center)
        }
        
        messageLabel.snp.makeConstraints { (make) ->  Void in
            make.centerX.equalTo(iconView.snp.centerX)
            make.top.equalTo(iconView.snp.bottom).offset(16)
            make.width.equalTo(224)
            make.height.equalTo(36)
        }
        
        registerButton.snp.makeConstraints { (make) ->  Void in
            make.left.equalTo(messageLabel.snp.left)
            make.top.equalTo(messageLabel.snp.bottom).offset(16)
            make.width.equalTo(100)
            make.height.equalTo(36)
        }
        
        loginButton.snp.makeConstraints { (make) ->  Void in
            make.right.equalTo(messageLabel.snp.right)
            make.top.equalTo(registerButton.snp.top)
            make.width.equalTo(registerButton.snp.width)
            make.height.equalTo(registerButton.snp.height)
        }
        
        maskIconView.snp.makeConstraints { (make) ->  Void in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.left)
            make.bottom.equalTo(registerButton.snp.bottom)
        }
        
    }
    
    fileprivate func setupSubViewsLayout() {
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: -60))
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: homeIconView, attribute: .centerY, relatedBy: .equal, toItem: iconView, attribute: .centerY, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: homeIconView, attribute: .centerX, relatedBy: .equal, toItem: iconView, attribute: .centerX, multiplier: 1.0, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .centerX, relatedBy: .equal, toItem: iconView, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .top, relatedBy: .equal, toItem: iconView, attribute: .bottom, multiplier: 1.0, constant: 16))
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 224))
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 36))
        
        //注册按钮约束
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .left, relatedBy: .equal, toItem: messageLabel, attribute: .left, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .top, relatedBy: .equal, toItem: messageLabel, attribute: .bottom, multiplier: 1.0, constant: 16))
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100))
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 36))
        //登录按钮约束
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: .right, relatedBy: .equal, toItem: messageLabel, attribute: .right, multiplier: 1.0, constant: 16))
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: .top, relatedBy: .equal, toItem: messageLabel, attribute: .bottom, multiplier: 1.0, constant: 16))
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100))
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 36))
        
        //遮罩约束
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[mask]-0-|", options: [], metrics: nil, views: ["mask":maskIconView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[mask]-(btnHeight)-[regButton]", options: [], metrics: ["btnHeight":-36], views: ["mask":maskIconView,"regButton":registerButton]))
    }
    
    private func setupUI() {
        backgroundColor = UIColor(white: 237.0/255.0, alpha: 1.0)
        
        addSubview(homeIconView)
        addSubview(iconView)
        addSubview(maskIconView)
        addSubview(messageLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        
        for v in subviews {
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
//        setupSubViewsLayout()
        setupSubViewsLayoutWithSnapKit()
    }
    
    func setupInfo(imageName:String?, title:String) {
        messageLabel.text = title
        guard let imgeName = imageName else {
            startAnim()
            return
        }
        homeIconView.isHidden = true
        sendSubviewToBack(maskIconView)
        iconView.image = UIImage(named: imgeName)
    }
    
    private func startAnim() {
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.toValue = 2 * Double.pi
        anim.repeatCount = MAXFLOAT
        anim.duration = 20
        anim.isRemovedOnCompletion = false
        iconView.layer.add(anim, forKey: nil)
    }
    
}
