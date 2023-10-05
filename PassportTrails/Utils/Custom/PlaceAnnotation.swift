//
//  PlaceAnnotation.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/10/05.
//

import MapKit

class PlaceAnnotation: NSObject, MKAnnotation {
    
    var place: Place?
    
    var title: String? {
        place?.title
    }
    var subtitle: String? {
        place?.subtitle
    }
    
    var coordinate: CLLocationCoordinate2D
    
    init(feature: MKGeoJSONFeature) {
        coordinate = feature.geometry[0].coordinate
        if let data = feature.properties, let place = try? JSONDecoder().decode(Place.self, from: data) {
            self.place = place
        }
    }
}
