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
        markerTintColor = .systemGray
        glyphTintColor = .label
        glyphImage = UIImage(systemName: "leaf")
        selectedGlyphImage = UIImage(systemName: "leaf.fill")
    }
}

final class VisitedPlaceAnnotationView: MKMarkerAnnotationView {
    
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
        markerTintColor = .systemGreen
        glyphTintColor = .label
        glyphImage = UIImage(systemName: "leaf")
        selectedGlyphImage = UIImage(systemName: "leaf.fill")
    }
}
