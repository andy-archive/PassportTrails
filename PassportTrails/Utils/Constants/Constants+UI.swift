//
//  Colors.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/10/19.
//

import UIKit

extension Constants {
    enum Color {
        static let label = UIColor.label
        static let secondaryLabel = UIColor.secondaryLabel
        static let background = UIColor.systemBackground
        static let groupedBackground = UIColor.systemGroupedBackground
        static let secondaryGroupedBackground = UIColor.secondarySystemGroupedBackground
        static let separator = UIColor.systemGray3.cgColor
        static let buttonTitle = UIColor.white
        static let buttonBackground = UIColor.systemBlue
        static let visitedAnnotation = UIColor.systemGreen
        static let notVisitedAnnotation = UIColor.systemGray
    }
    
    enum Image {
        enum TabBar {
            static let map = UIImage(systemName: "map")
            static let selectedMap = UIImage(systemName: "map.fill")
            static let list = UIImage(systemName: "list.bullet.rectangle")
            static let selectedList = UIImage(systemName: "list.bullet.rectangle.fill")
            static let settings = UIImage(systemName: "gearshape")
            static let selectedSettings = UIImage(systemName: "gearshape.fill")
        }
        static let leaf = UIImage(systemName: "leaf")
        static let selectedLeaf = UIImage(systemName: "leaf.fill")
        static let leafCircle = UIImage(systemName: "leaf.circle")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        static let upChevron = UIImage(systemName: "chevron.up")?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
        static let downChevron = UIImage(systemName: "chevron.down")?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
    }
    
    static let Screen = UIScreen.main.bounds
}
