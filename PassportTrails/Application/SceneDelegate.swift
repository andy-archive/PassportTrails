//
//  SceneDelegate.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/09/26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        let firstNav = UINavigationController(rootViewController: StampMapViewController())
        let secondNav = UINavigationController(rootViewController: StampListViewController())
        let thirdNav = UINavigationController(rootViewController: AppSettingViewController())

        firstNav.configureAppearance()
        secondNav.configureAppearance()
        thirdNav.configureAppearance()

        let tabBarController = UITabBarController()
        
        tabBarController.configureAppearance()
        tabBarController.setViewControllers([firstNav, secondNav, thirdNav], animated: true)

        if let items = tabBarController.tabBar.items {
            items[0].image = Constants.Image.TabBar.map
            items[0].selectedImage = Constants.Image.TabBar.selectedMap
            items[0].title = Constants.Text.TabBar.mapTitle
            
            items[1].image = Constants.Image.TabBar.list
            items[1].selectedImage = Constants.Image.TabBar.selectedList
            items[1].title = Constants.Text.TabBar.listTitle
            
            items[2].image = Constants.Image.TabBar.settings
            items[2].selectedImage = Constants.Image.TabBar.selectedSettings
            items[2].title = Constants.Text.TabBar.settingTitle
        }
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        window?.rootViewController = tabBarController
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

