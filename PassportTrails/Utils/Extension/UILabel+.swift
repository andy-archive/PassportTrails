//
//  UILabel+.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/10/19.
//

import UIKit

extension UILabel {
    func showPlaceTitleWithDistance(title: String, distance: Double) {
        self.text = "📐 \(Int(distance)) m\n\n🍀 \(title)"
    }
    
    func showNoNearbyPlace() {
        self.text = "주변 \(Int(Constants.Distance.isNearbyPlace)) m 내에 가까운 장소가 없습니다"
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
