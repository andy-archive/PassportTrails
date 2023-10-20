//
//  MKAnnotation+.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/10/21.
//

import MapKit

extension MKAnnotation {
    func showDistance(from: MKAnnotation) -> CLLocationDistance {
        let startLocation = CLLocation(latitude: self.coordinate.latitude, longitude: self.coordinate.longitude)
        let endLocation = CLLocation(latitude: from.coordinate.latitude, longitude: from.coordinate.longitude)
        return startLocation.distance(from: endLocation)
    }
}
