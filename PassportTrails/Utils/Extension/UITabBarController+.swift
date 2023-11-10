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
            tabBarAppearance.backgroundColor = Constants.Color.secondaryGroupedBackground
            
            tabBar.standardAppearance = tabBarAppearance
            tabBar.scrollEdgeAppearance = tabBarAppearance
            
            tabBar.tintColor = Constants.Color.label
            tabBar.unselectedItemTintColor = Constants.Color.background
        }
    }
}
