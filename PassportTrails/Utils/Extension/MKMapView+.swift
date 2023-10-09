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
        trackingButton.customView?.tintColor = .systemBlue
        trackingButton.customView?.frame.size = CGSize(width: 50, height: 50)
        
        let toolBarFrame = CGRect(origin: .zero, size: CGSize(width: 50, height: 50))
        let toolbar = UIToolbar(frame: toolBarFrame)
        toolbar.isTranslucent = false
        
        let flex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolbar.items = [flex, trackingButton, flex]
        
        let roundedSquare = UIView()
        roundedSquare.layer.cornerRadius = 5
        roundedSquare.layer.masksToBounds = true
        
        self.addSubview(roundedSquare)
        roundedSquare.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            roundedSquare.widthAnchor.constraint(equalToConstant: 50),
            roundedSquare.heightAnchor.constraint(equalToConstant: 50),
            roundedSquare.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
            roundedSquare.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
        ])
        
        roundedSquare.addSubview(toolbar)
    }
}

