//
//  MainViewController.swift
//  ZYWeiBo
//
//  Created by ZhangYu on 2021/7/16.
//

import UIKit

class MainViewController: UITabBarController {

    private lazy var composedButton: UIButton = UIButton(imageName: "tabbar_compose_icon_add", backImageName: "tabbar_compose_button")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewControllers()
        setupComposedButton()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBar.bringSubviewToFront(composedButton)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MainViewController {
    private func addChildViewControllers() {
        tabBar.tintColor =  UIColor.orange
        addChildViewController(vc: HomeTableViewController(), title: "首页", imageName: "tabbar_home")
        addChildViewController(vc: MessageTableViewController(), title: "消息", imageName: "tabbar_message_center")
        addChild(UIViewController())
        addChildViewController(vc: DiscoverTableViewController(), title: "发现", imageName: "tabbar_discover")
        addChildViewController(vc: ProfileTableViewController(), title: "我", imageName: "tabbar_profile")
    }
    
    
    private func addChildViewController(vc: UIViewController, title:String, imageName:String) {
        vc.title = title
        vc.tabBarItem.image = UIImage(named: imageName)
        let nav = UINavigationController(rootViewController: vc)
        addChild(nav)
    }
    
    private func setupComposedButton() {
        tabBar.addSubview(composedButton)
        let count = children.count
        let w = tabBar.bounds.width/CGFloat(count) - 1
        composedButton.frame = tabBar.bounds.insetBy(dx: 2 * w, dy: 0)
        composedButton.addTarget(self, action: #selector(clickComposedButton), for: .touchUpInside)
    }
    
    @objc private func clickComposedButton() {
        print("\(#function)")
    }
}
