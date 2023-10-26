//
//  Notification+.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/10/12.
//

import Foundation

extension Notification.Name {
    static let stampButtonClicked = Notification.Name("stampButtonClicked")
    static let selectAnnotation = Notification.Name("selectAnnotation")
    static let deselectAnnotation = Notification.Name("deselectAnnotation")
    static let reloadStampCollectionView = Notification.Name("reloadCollectionView")
}
