//
//  UIViewController+.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/10/10.
//

import UIKit

extension UIViewController {
    var selectedTabBarViewController: UIViewController? {
        return tabBarController?.selectedViewController
    }
    
    func presentPlaceArrivalView() {
        let vc = PlaceArrivalViewController()
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.custom(identifier: .medium, resolver: { context in
                return Constants.Sheet.placeArrivalHeight
            })]
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = Constants.Sheet.cornerRadius
        }
        present(vc, animated: true)
    }
    
    func presentStampDetailView(place: PlaceRealm) {
        let vc = StampDetailViewController()
        vc.place = place
        
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [
                .custom(identifier: .medium, resolver: { context in
                    return UIScreen.main.bounds.height * Constants.Sheet.smallHeightRatio
                }),
                .custom(identifier: .large, resolver: { context in
                    return UIScreen.main.bounds.height * Constants.Sheet.largeHeightRatio
                }),
            ]
            sheet.prefersGrabberVisible = true
            sheet.prefersScrollingExpandsWhenScrolledToEdge = true
            sheet.preferredCornerRadius = Constants.Sheet.cornerRadius
        }
        present(vc, animated: true)
    }
    
    func isStampMapViewController(viewController: UIViewController) -> Bool {
        guard let selectedViewController = viewController.selectedTabBarViewController as? UINavigationController,
              let rootViewController = selectedViewController.rootViewController
        else { return false }
        
        guard rootViewController is StampMapViewController else { return false }
        
        return true
    }
}
