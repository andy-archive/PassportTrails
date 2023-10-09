//
//  StampMapViewController.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/09/23.
//

import UIKit
import MapKit

final class StampMapViewController: BaseViewController {
    
    private let locationManager = CLLocationManager()
    private let mapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.topViewController?.title = "스탬프 지도"
        
        configureLocationManager()
        configureMapView()
        
        fetchGeoJson(fileName: "place")
    }
    
    private func findNearestAnnotation(_ currentLocation: CLLocationCoordinate2D) -> MKAnnotation? {
        let annotations = mapView.annotations
        guard annotations.count > 0 else { return nil }

        var nearestAnnotation: MKAnnotation?
        var nearestDistance: CLLocationDistance = Double.infinity

        let currentUserLocation = CLLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude)

        for annotation in annotations {
            guard annotation !== mapView.userLocation else { continue }

            let annotationCoordinate = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
            let distance = currentUserLocation.distance(from: annotationCoordinate)

            if distance < nearestDistance {
                nearestDistance = distance
                nearestAnnotation = annotation
            }
        }
        
        return nearestAnnotation
    }
    
    private func fetchGeoJson(fileName: String) -> Void {
        guard let geoJsonUrl = Bundle.main.url(forResource: fileName, withExtension: "geojson"),
              let geoJsonData = try? Data.init(contentsOf: geoJsonUrl) else {
            fatalError("Unable to fetch geojson")
        }
        
        if let features = try? MKGeoJSONDecoder().decode(geoJsonData) as? [MKGeoJSONFeature] {
            let placeAnnotations = features.map { PlaceAnnotation(feature: $0) }
            
            mapView.addAnnotations(placeAnnotations)
            mapView.showAnnotations(placeAnnotations, animated: true)
        }
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
    
    private func configureMapView() {
        mapView.delegate = self
        mapView.register(PlaceAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.mapType = .standard
        mapView.showsUserLocation = true
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.userTrackingMode = .follow
    }
    
    private func configureLocationManager() {
        locationManager.delegate = self
        
        checkDeviceLocationAuthorization()
    }
    
    //MARK: LocationAuthorization
    
    private func showLocationSettingAlert() {
        let alert = UIAlertController(title: "위치 권한 설정", message: "스탬프 투어를 위해서는 위치 권한이 필요합니다.\n'설정 → 개인 정보 보호'에서\n위치를 허용해 주세요.", preferredStyle: .alert)
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSetting)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(goSetting)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    private func checkDeviceLocationAuthorization() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                let authorization: CLAuthorizationStatus
                if #available(iOS 14.0, *) {
                    authorization = self.locationManager.authorizationStatus
                } else {
                    authorization = CLLocationManager.authorizationStatus()
                }
                DispatchQueue.main.async {
                    self.checkCurrentLocationAuthorization(status: authorization)
                }
            } else {
                print("위치 서비스가 꺼져 있어 위치 권한 요청을 할 수 없습니다")
            }
        }
    }
    
    private func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("GPS의 권한이 설정되지 않음")
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("해당 앱은 GPS의 권한을 요청할 수 없음")
        case .denied:
            print("GPS의 권한이 거부됨")
            showLocationSettingAlert()
        case .authorizedAlways:
            print("GPS의 권한이 항상으로 설정됨")
        case .authorizedWhenInUse:
            print("GPS의 권한이 앱을 사용하는 동안으로 설정됨")
            locationManager.startUpdatingLocation()
        @unknown default:
            print("GPS default")
        }
    }
}

//MARK: MKMapViewDelegate

extension StampMapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        } else {
            let view = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier, for: annotation)
            return view
        }
    }
}

//MARK: CLLocationManagerDelegate

extension StampMapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1500, longitudinalMeters: 1500)
            mapView.setRegion(region, animated: true)
        }
        locationManager.stopUpdatingLocation()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkDeviceLocationAuthorization()
    }
}
