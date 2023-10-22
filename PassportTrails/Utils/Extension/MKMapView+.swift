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
            compassButton.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.MKButton.verticalConstant * 1.8),
            compassButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.MKButton.horizontalConstant),
            compassButton.widthAnchor.constraint(equalToConstant: Constants.MKButton.width),
            compassButton.heightAnchor.constraint(equalToConstant: Constants.MKButton.height)
        ])
    }
}

