//
//  SceneDelegate.swift
//  ZYWeiBo
//
//  Created by ZhangYu on 2021/7/16.
//

import UIKit


class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    private(set) static var shared: SceneDelegate?
    
    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        
//        guard let _ = (scene as? UIWindowScene) else { return }
        
        Self.shared = self;
        let windowScene :UIWindowScene = scene as! UIWindowScene
        self.window = UIWindow.init(windowScene: windowScene)
        self.window?.frame = windowScene.coordinateSpace.bounds
//        self.window?.rootViewController = MainViewController.init()
//        self.window?.rootViewController = NewFeatureViewController.init()
//        self.window?.rootViewController = WelcomeViewController.init()
        self.window?.rootViewController = defaultRootViewController
        self.window?.makeKeyAndVisible()
        
        
        NotificationCenter.default.addObserver(forName:NSNotification.Name(ZYSwitchRootViewControllerNotification), object: nil, queue: nil) { (notification) in
            let vc = notification.object != nil ? WelcomeViewController() : MainViewController()
            self.window?.rootViewController = vc
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    deinit {
        //???????????????
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(ZYSwitchRootViewControllerNotification), object: nil)
     
    }


}

extension SceneDelegate {
    private var defaultRootViewController: UIViewController{
        if UserAccountViewModel.sharedUserAccount.userLogon {
            return isNewVersion ? NewFeatureViewController() : WelcomeViewController()
        }
        return MainViewController()
    }
    
    
    private var isNewVersion:Bool {
        let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        let version = Double(currentVersion)!
        print("????????????\(version)")
        let sandboxVersionKey = "sandboxVersionKey"
        let sandboxVersion = UserDefaults.standard.double(forKey: sandboxVersionKey)
        print("????????????\(sandboxVersion)")
        UserDefaults.standard.setValue(version, forKey: sandboxVersionKey)
        return version > sandboxVersion
    }
}

