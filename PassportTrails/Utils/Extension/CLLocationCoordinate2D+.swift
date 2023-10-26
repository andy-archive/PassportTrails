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
    
    func showMiddleCoordinate(between coordinate: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        let lon1 = longitude * .pi / 180
        let lon2 = coordinate.longitude * .pi / 180
        let lat1 = latitude * .pi / 180
        let lat2 = coordinate.latitude * .pi / 180
        let dLon = lon2 - lon1
        let x = cos(lat2) * cos(dLon)
        let y = cos(lat2) * sin(dLon)
        
        let lat3 = atan2( sin(lat1) + sin(lat2), sqrt((cos(lat1) + x) * (cos(lat1) + x) + y * y) )
        let lon3 = lon1 + atan2(y, cos(lat1) + x)
        
        let center:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat3 * 180 / .pi, lon3 * 180 / .pi)
        return center
    }
}
