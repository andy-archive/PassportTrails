//
//  CustomClusterAnnotationView.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/09/25.
//

import UIKit
import MapKit

final class CustomClusterAnnotationView: MKAnnotationView {
    
    override var annotation: MKAnnotation? {
        didSet {
            guard let _ = annotation as? MKClusterAnnotation else {
                assertionFailure("Using LocationDataMapClusterView with wrong annotation type")
                return
            }
            displayPriority = .defaultHigh
            collisionMode = .circle
        }
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        frame = CGRect(x: 0, y: 0, width: 40, height: 50)
        centerOffset = CGPoint(x: 0, y: -frame.size.height / 2)
        
        canShowCallout = true
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        
        setNeedsLayout()
    }
    
    private func setupUI() {
        backgroundColor = .clear
    }
}
