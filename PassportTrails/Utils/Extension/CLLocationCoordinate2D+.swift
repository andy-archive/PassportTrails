//
//  CLLocationCoordinate2D+.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/10/21.
//

import MapKit

extension CLLocationCoordinate2D {
    func isEqualTo(coordinate: CLLocationCoordinate2D) -> Bool {
        return self.latitude == coordinate.latitude && self.longitude == coordinate.longitude
    }
}
