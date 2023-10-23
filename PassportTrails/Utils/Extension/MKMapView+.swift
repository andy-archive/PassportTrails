//
//  MKMapView+.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/10/09.
//

import MapKit

extension MKMapView {
    func configureCompassButton() {
        let compassButton = MKCompassButton(mapView: self)
        compassButton.compassVisibility = .adaptive
        
        self.addSubview(compassButton)
        compassButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            compassButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.MKButton.horizontalConstant),
            compassButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            compassButton.widthAnchor.constraint(equalToConstant: Constants.MKButton.width),
            compassButton.heightAnchor.constraint(equalToConstant: Constants.MKButton.height)
        ])
    }
    
    func showLocationOnCenter(coordinate: CLLocationCoordinate2D) {
        var altitude = self.camera.altitude
        
        if self.camera.altitude > Constants.Distance.maximumAltitude {
            altitude = Constants.Distance.standardAltitude
        } else if self.camera.altitude < Constants.Distance.minimumAltitude {
            altitude = Constants.Distance.standardAltitude
        }
        
        let camera = MKMapCamera(lookingAtCenter: coordinate, fromEyeCoordinate: coordinate, eyeAltitude: altitude)
        
        camera.heading = self.camera.heading
        camera.pitch = 0
        
        self.setCamera(camera, animated: true)
    }
}

