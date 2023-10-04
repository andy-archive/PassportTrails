//
//  CustomAnnotationView.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/09/24.
//

import UIKit
import MapKit

final class CustomAnnotationView: MKMarkerAnnotationView {
    
    override var annotation: MKAnnotation? {
        didSet {
            markerTintColor = .systemYellow
            glyphTintColor = .black
            clusteringIdentifier = "total"
        }
    }
    
    private let countLabel = UILabel()
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        frame = CGRect(x: 0, y: 0, width: 40, height: 50)
        centerOffset = CGPoint(x: 0, y: -frame.size.height / 2)
        
        canShowCallout = true
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        
        setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setupUI() {
        backgroundColor = .clear
    }
}

