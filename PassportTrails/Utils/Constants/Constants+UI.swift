//
//  Colors.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/10/19.
//

import UIKit

extension Constants {
    enum Color {
        static let background = UIColor.systemBackground
        static let label = UIColor.label
        static let secondaryLabel = UIColor.secondaryLabel
        static let separator = UIColor.systemGray3.cgColor
    }
    
    enum Image {
        static let downChevron = UIImage(systemName: "chevron.down")?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
        static let compactUpChevron = UIImage(systemName: "chevron.compact.up")?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
        static let compactDownChevron = UIImage(systemName: "chevron.compact.down")?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
    }
}
