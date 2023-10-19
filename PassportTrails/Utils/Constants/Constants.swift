//
//  Constants.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/10/19.
//

import Foundation

enum Constants {
    enum Text {
        static let stampListTitle = "스탬프 목록"
        static let arrivedTitle = "🎉 장소에 도착했습니다 🎉"
        static let arrivedSubtitle = "아래 버튼을 눌러 스탬프를 받으세요 👇"
        static let arrivedButtonTitle = "스탬프 받기"
        static let clover = "🍀"
        static let tabBarMapTitle = "지도"
        static let tabBarListTitle = "목록"
    }
    
    enum FontSize {
        static let title: CGFloat = 30
        static let subtitle: CGFloat = 17
        static let buttonTitle: CGFloat = 20
        static let detail: CGFloat = 15
    }
    
    enum Design {
        static let lineSpacing: CGFloat = 8
        static let horizontalConstant: CGFloat = 30
        static let verticalConstant: CGFloat = 30
        static let separatorWidth: CGFloat = 1
        static let borderWidth: CGFloat = 0.5
        static let listStampRatio = 0.7
        static let detailStampRatio = 0.3
    }
    
    enum Button {
        static let height: CGFloat = 60
        static let radius: CGFloat = 20
    }
    
    enum UserTrackingButton {
        static let height: CGFloat = 42
        static let width: CGFloat = 42
        static let corderRadius: CGFloat = 5
        static let horizontalConstant: CGFloat = 8
        static let verticalConstant: CGFloat = 64
    }
    
    enum Cell {
        static let numberOfItem: CGFloat = 2
        static let sectionSpacing: CGFloat = 0
        static let itemSpacing: CGFloat = 0
        static let borderWidth: CGFloat = 0.5
    }
    
    enum Distance {
        static let didArrivePlace: Double = 15
        static let willLeavePlace: Double = 30
        static let isNearbyPlace: Double = 45
    }
    
    enum Sheet {
        static let mediumHeightRatio: Double = 0.35
        static let cornerRadius: CGFloat = 30
    }
}
