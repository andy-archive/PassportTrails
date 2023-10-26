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
            compassButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constants.MKButton.verticalConstant * 2 + Constants.CLLocationButton.height),
            compassButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.MKButton.horizontalConstant),
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

