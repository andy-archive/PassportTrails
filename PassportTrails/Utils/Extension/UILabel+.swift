//
//  UILabel+.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/10/19.
//

import UIKit

extension UILabel {
    func showDistanceInMeter(distance: Double) {
        self.text = "🧭 \(Int(distance))m"
    }
    
    func showPlaceTitle(title: String) {
        self.text = "\(title)"
    }
    
    func showNoNearbyPlace() {
        self.text = "반경 \(Int(Constants.Distance.isNearbyPlace)) m 내에 가까운 장소가 없습니다"
    }
    
    func configureSpaceBetweenLines(lineSpacing: CGFloat) {
        guard let labelText = self.text else { return }
        
        let attrString = NSMutableAttributedString(string: labelText)
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineSpacing = lineSpacing
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        
        self.attributedText = attrString
    }
}
