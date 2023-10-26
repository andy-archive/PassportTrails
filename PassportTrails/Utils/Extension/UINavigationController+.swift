//
//  UINavigationController+.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/10/14.
//

import UIKit

extension UINavigationController {
    var rootViewController: UIViewController? {
        return viewControllers.first
    }
    
    func configureAppearance() {
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithDefaultBackground()
            appearance.backgroundColor = Constants.Color.background
            
            appearance.largeTitleTextAttributes = [
                .font: UIFont.boldSystemFont(ofSize: 30),
                .foregroundColor: Constants.Color.label
            ]
            appearance.titleTextAttributes = [
                .font: UIFont.boldSystemFont(ofSize: 17),
                .foregroundColor: Constants.Color.label
            ]
            
            navigationBar.standardAppearance = appearance
            navigationBar.compactAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
            
            navigationBar.prefersLargeTitles = true
        }
    }
}

