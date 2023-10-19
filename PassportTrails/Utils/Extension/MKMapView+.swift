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
        trackingButton.customView?.frame.size = CGSize(width: Constants.UserTrackingButton.width, height: Constants.UserTrackingButton.height)
        
        let toolBarFrame = CGRect(origin: .zero, size: CGSize(width: Constants.UserTrackingButton.width, height: Constants.UserTrackingButton.height))
        let toolbar = UIToolbar(frame: toolBarFrame)
        toolbar.isTranslucent = false
        
        let flex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolbar.items = [flex, trackingButton, flex]
        
        let roundedSquare = UIView()
        roundedSquare.layer.cornerRadius = Constants.UserTrackingButton.corderRadius
        roundedSquare.layer.masksToBounds = true
        
        self.addSubview(roundedSquare)
        roundedSquare.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            roundedSquare.widthAnchor.constraint(equalToConstant: Constants.UserTrackingButton.width),
            roundedSquare.heightAnchor.constraint(equalToConstant: Constants.UserTrackingButton.height),
            roundedSquare.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.UserTrackingButton.verticalConstant),
            roundedSquare.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.UserTrackingButton.horizontalConstant),
        ])
        
        roundedSquare.addSubview(toolbar)
    }
}

