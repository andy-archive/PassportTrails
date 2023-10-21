//
//  MKAnnotation+.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/10/21.
//

import MapKit

extension MKAnnotation {
    var location: CLLocation {
        return CLLocation(latitude: self.coordinate.latitude, longitude: self.coordinate.longitude)
    }
    
    func showDistance(from: MKAnnotation) -> CLLocationDistance {
        let startLocation =  self.location
        let endLocation = from.location
        return startLocation.distance(from: endLocation)
    }
}
