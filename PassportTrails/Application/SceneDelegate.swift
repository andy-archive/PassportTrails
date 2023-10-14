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

        if #available(iOS 15.0, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithDefaultBackground()
            navigationBarAppearance.backgroundColor = .systemBackground
            
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
            
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            tabBarAppearance.backgroundColor = .systemBackground
            
            UITabBar.appearance().standardAppearance = tabBarAppearance
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }

        let firstNav = UINavigationController(rootViewController: StampMapViewController())
        let secondNav = UINavigationController(rootViewController: StampListViewController())

        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .label
        tabBarController.tabBar.unselectedItemTintColor = .systemBackground
        tabBarController.setViewControllers([firstNav, secondNav], animated: true)

        if let items = tabBarController.tabBar.items {
            items[0].image = UIImage(systemName: "map")
            items[0].selectedImage = UIImage(systemName: "map.fill")
            items[0].title = "지도"
            
            items[1].image = UIImage(systemName: "list.bullet.rectangle")
            items[1].selectedImage = UIImage(systemName: "list.bullet.rectangle.fill")
            items[1].title = "목록"
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

