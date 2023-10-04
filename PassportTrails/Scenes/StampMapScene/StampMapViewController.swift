//
//  StampMapViewController.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/09/23.
//

import UIKit
import MapKit

final class StampMapViewController: BaseViewController {
    
    private let mapView: MKMapView = {
        let view = MKMapView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.topViewController?.title = "스탬프 지도"
    }
    
    override func configureHierarchy() {
        view.addSubview(mapView)
    }
    
    override func setConstraints() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}


