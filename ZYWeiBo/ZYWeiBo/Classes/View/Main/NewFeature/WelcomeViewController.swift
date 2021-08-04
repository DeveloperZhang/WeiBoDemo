//
//  WelcomeViewController.swift
//  ZYWeiBo
//
//  Created by ZhangYu on 2021/7/30.
//

import UIKit


class WelcomeViewController: UIViewController {

    
    private lazy var backImageView: UIImageView = UIImageView(image: UIImage.init(named: "ad_background"))
    
    private lazy var iconView: UIImageView = {
        let iv = UIImageView.init(imageName: "avatar_default_big")
        iv.layer.cornerRadius = 45
        iv.layer.masksToBounds = true
        return iv
    }()
    
    private lazy var welcomeLabel: UILabel = UILabel.init(title: "欢迎归来", fontSize: 18)
    
    override func loadView() {
        view = backImageView
        setupUI()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        iconView.sd_setImage(with:UserAccountViewModel.sharedUserAccount.avatarUrl as URL, placeholderImage: UIImage.init(named: "avatar_default_big"))
        
       
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        iconView.snp.updateConstraints { (make) in
            make.bottom.equalTo(view.snp.bottom).offset(-view.bounds.height + 200)
            
        }
        
        self.welcomeLabel.alpha = 0
        
        /**
          * usingSpringWithDamping 弹力系数
          * initialSpringVelocity 表示初始速度
          * options为动画执行的选项
          * animations为动画的代码块
         */
        
        UIView.animate(withDuration: 1.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: [],animations:{
            self.view.layoutIfNeeded()
        }){ (_) in
            UIView.animate(withDuration: 0.8) {
                self.welcomeLabel.alpha = 1
            } completion: { (_) in
                NotificationCenter.default.post(name: NSNotification.Name(ZYSwitchRootViewControllerNotification), object: nil)
            }

        }

    }
    

}

extension WelcomeViewController {
    private func setupUI() {
        view.addSubview(iconView)
        iconView.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.snp.bottom).offset(-200)
            make.width.equalTo(90)
            make.height.equalTo(90)
        }
        
        view.addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(iconView.snp.centerX)
            make.top.equalTo(iconView.snp.bottom).offset(16)
        }
    }
}
