//
//  MKMapView+.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/10/09.
//

import MapKit

extension MKMapView {
    func configureUserTrackingButton() {
        let trackingButton = MKUserTrackingBarButtonItem(mapView: self)
        trackingButton.customView?.tintColor = .label
        trackingButton.customView?.frame.size = CGSize(width: Constants.MKButton.width, height: Constants.MKButton.height)
        
        let toolBarFrame = CGRect(origin: .zero, size: CGSize(width: Constants.MKButton.width, height: Constants.MKButton.height))
        let toolbar = UIToolbar(frame: toolBarFrame)
        toolbar.isTranslucent = false
        
        let flex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolbar.items = [flex, trackingButton, flex]
        
        let roundedSquare = UIView()
        roundedSquare.layer.cornerRadius = Constants.MKButton.corderRadius
        roundedSquare.layer.masksToBounds = true
        
        self.addSubview(roundedSquare)
        roundedSquare.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            roundedSquare.widthAnchor.constraint(equalToConstant: Constants.MKButton.width),
            roundedSquare.heightAnchor.constraint(equalToConstant: Constants.MKButton.height),
            roundedSquare.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.MKButton.verticalConstant),
            roundedSquare.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.MKButton.horizontalConstant),
        ])
        
        roundedSquare.addSubview(toolbar)
    }
    
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

