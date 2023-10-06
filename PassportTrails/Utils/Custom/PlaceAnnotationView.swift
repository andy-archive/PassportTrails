//
//  PlaceAnnotationView.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/09/24.
//

import UIKit
import MapKit

final class PlaceAnnotationView: MKMarkerAnnotationView {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        clusteringIdentifier = "place"
        
        canShowCallout = true
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForDisplay() {
        super.prepareForDisplay()
        
        displayPriority = .defaultLow
        markerTintColor = .systemYellow
        glyphTintColor = .black
        selectedGlyphImage = UIImage(systemName: "star.fill")
    }
}
