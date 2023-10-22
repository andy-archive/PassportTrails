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
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        
        displayPriority = .defaultHigh
        markerTintColor = Constants.Color.notVisitedAnnotation
        glyphTintColor = Constants.Color.background
        glyphImage = Constants.Image.leaf
        selectedGlyphImage = Constants.Image.selectedLeaf
    }
}

final class VisitedPlaceAnnotationView: MKMarkerAnnotationView {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        
        displayPriority = .defaultLow
        markerTintColor = Constants.Color.visitedAnnotation
        glyphTintColor = Constants.Color.background
        glyphImage = Constants.Image.leaf
        selectedGlyphImage = Constants.Image.selectedLeaf
    }
}
