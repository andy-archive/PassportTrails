//
//  Constants.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/10/19.
//

import Foundation

enum Constants {
    
    enum System {
        static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        static let bundleID = Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String
        static let appID = 6470292190
    }
    
    enum Text {
        
        enum TabBar {
            static let mapTitle = "지도"
            static let listTitle = "목록"
            static let settingTitle = "설정"
        }
        
        enum NavigationBar {
            static let stampListTitle = "스탬프 목록"
            static let settingTitle = "설정"
        }
        
        static let arrivedTitle = "🎉 장소에 도착했습니다 🎉"
        static let arrivedSubtitle = "아래 버튼을 눌러 스탬프를 받으세요 👇"
        static let arrivedButtonTitle = "스탬프 받기"
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
        static let gloomFilterIntensityRatio = 1.0
        static let stampRoundBorderWidth: CGFloat = 2.0
    }
    
    enum Button {
        static let height: CGFloat = 60
        static let cornerRadius: CGFloat = 20
    }
    
    enum MKButton {
        static let horizontalConstant: CGFloat = 12
        static let verticalConstant: CGFloat = 12
    }
    
    enum CLLocationButton {
        static let width: CGFloat = 50
        static let height: CGFloat = 50
    }
    
    enum RadarView {
        static let heightRatio: CGFloat = 1.4
        static let widthRatio: CGFloat = 0.6
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
        static let minimumDirectionAltitude: Double = 100
        static let directionAltitudeRatio: Double = 3.5
        static let isNearbyPlace: Double = 1000
        static let standardAltitude: Double = 5000
        static let minimumAltitude: Double = 180
        static let maximumAltitude: Double = 50000
    }
    
    enum Sheet {
        static let placeArrivalHeight: CGFloat = 220
        static let smallHeightRatio: Double = 0.3
        static let largeHeightRatio: Double = 0.8
        static let cornerRadius: CGFloat = 30
    }
    
    enum Setting {
        
        enum Section {
            static let support = "문의하기"
            static let appInfo = "앱 정보"
        }
        
        enum Item {
            static let latestVersion = "최신 버전"
            static let updateAvailable = "업데이트 하기"
        }
        
        static let supportList = ["📷 인스타그램 문의", "📝 구글 폼 문의"]
        static let appInfoList = ["📖 개인정보 처리방침", "🪪 오픈소스 라이선스", "📦 앱 버전"]
    }
    
    enum LinkUrl {
        enum AppSupport {
            static let instagram = "https://www.instagram.com/oneotwo_102/"
            static let googleForm = "https://docs.google.com/forms/d/e/1FAIpQLSeZWDyXjjR9i2IOLYd9X61xLnOmGrfoevv2faCUfRgde60zZg/viewform?usp=sf_link"
        }
        
        enum AppInfo {
            static let privacyPolicy = "https://www.notion.so/eee7789919b44b53ba3561c569a50893?pvs=4"
            static let openSourceLicence = "https://www.notion.so/3b8bc3c919bb427f973c857d984049d4?pvs=4"
            static let appStore = "https://apps.apple.com/kr/app/%EC%9D%BC%EA%B3%B5%EC%9D%B4-102-%EC%9D%BC%EC%83%81-%EA%B3%B5%EA%B0%84%EC%9D%98-%EC%9D%B4%EC%95%BC%EA%B8%B0/id6470292190"
            static let itunesBundleID = "https://itunes.apple.com/lookup?bundleId=com.andyarchive.oneotwo&country=kr"
            static let itunesAppID = "https://itunes.apple.com/lookup?id=6470292190&country=kr"
        }
    }
}
