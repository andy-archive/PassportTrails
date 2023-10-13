//
//  UIViewController+.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/10/10.
//

import UIKit

extension UIViewController {
    func presentPlaceArrivalView() {
        let vc = PlaceArrivalViewController()
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.custom(identifier: .medium, resolver: { context in
                return UIScreen.main.bounds.height * 0.35
            })]
            
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 30
            sheet.largestUndimmedDetentIdentifier = .medium
        }
        present(vc, animated: true)
    }
}
