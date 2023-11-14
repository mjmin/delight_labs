//
//  SceneDelegate.swift
//  delight_labs
//
//  Created by Minji Kim on 2023/11/13.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        // 탭바컨트롤러 생성
        let tabBarVC = UITabBarController()
        
        let vc1 = UIViewController()
        vc1.view.backgroundColor = .white
        let vc2 = UIViewController()
        vc2.view.backgroundColor = .white
        let vc3 = MainViewController()
        let vc4 = UIViewController()
        vc4.view.backgroundColor = .white
        
        tabBarVC.setViewControllers([vc1, vc2, vc3, vc4], animated: false)
        tabBarVC.modalPresentationStyle = .fullScreen
        tabBarVC.tabBar.backgroundColor = .white
        tabBarVC.selectedViewController = vc3
        tabBarVC.tabBar.tintColor = .navy
        
        guard let items = tabBarVC.tabBar.items else { return }
        items[0].image = UIImage(named: "tab1")
        items[1].image = UIImage(named: "tab2")
        items[2].image = UIImage(named: "tab3")
        items[3].image = UIImage(named: "tab4")
        
        let tabBar = tabBarVC.tabBar
        let selectBar = UIImage().createSelectionIndicator(color : .navy, size: CGSizeMake(tabBar.frame.width/CGFloat(items.count) - 40, tabBar.frame.height), lineWidth: 7.0)
        //        selectBar.transform = CGAffineTransform(scaleX: -1, y: 1); //Flipped
        //        selectBar.withHorizontallyFlippedOrientation()
        tabBarVC.tabBar.selectionIndicatorImage = selectBar
        
        window?.rootViewController = tabBarVC
        window?.makeKeyAndVisible()
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
    
    
}

