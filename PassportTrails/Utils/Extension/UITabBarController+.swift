//
//  UITabBarController+.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/10/14.
//

import UIKit

extension UITabBarController {
    func configureAppearance() {
        if #available(iOS 15.0, *) {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            tabBarAppearance.backgroundColor = .systemBackground
            
            tabBar.standardAppearance = tabBarAppearance
            tabBar.scrollEdgeAppearance = tabBarAppearance
            
            tabBar.tintColor = .label
            tabBar.unselectedItemTintColor = .systemBackground
        }
    }
}
