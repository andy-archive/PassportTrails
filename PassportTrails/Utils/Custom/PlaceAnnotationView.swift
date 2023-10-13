//
//  PlaceAnnotationView.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/09/24.
//

import UIKit
import MapKit

private let placeClusterID = "placeCluster"

final class PlaceAnnotationView: MKMarkerAnnotationView {
    
    static let reuseIdentifier = "placeAnnotation"
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        clusteringIdentifier = "place"
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForDisplay() {
        super.prepareForDisplay()
        
        displayPriority = .defaultHigh
        markerTintColor = .systemYellow
        glyphTintColor = .black
        glyphImage = UIImage(systemName: "star")
        selectedGlyphImage = UIImage(systemName: "star.fill")
    }
}

final class VisitedPlaceAnnotationView: MKMarkerAnnotationView {
    
    static let reuseIdentifier = "visitedPlaceAnnotation"
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        clusteringIdentifier = "placeCluster"
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForDisplay() {
        super.prepareForDisplay()
        
        displayPriority = .defaultLow
        markerTintColor = .darkGray
        glyphTintColor = .systemGray6
        glyphImage = UIImage(systemName: "checkmark.circle")
        selectedGlyphImage = UIImage(systemName: "checkmark.circle.fill")
    }
}
