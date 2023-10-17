//
//  StampMapViewController.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/09/23.
//

import UIKit
import MapKit
import RealmSwift

final class StampMapViewController: BaseViewController {
    
    private let locationManager = CLLocationManager()
    private let mapView = MKMapView()
    
    private var placeAnnotations = [PlaceAnnotation]()
    private var nearestAnnotation: PlaceAnnotation?
    private var isArrivedToPlace = false
    
    private let repository = PlaceRepository()
    private let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        configureLocationManager()
        configureMapView()
        
        fetchGeoJson(fileName: "place")
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateAnnotation), name: NSNotification.Name.stampButtonClicked, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(selectAnnotation), name: NSNotification.Name.selectAnnotation, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deselectAnnotation), name: NSNotification.Name.deselectAnnotation, object: nil)
    }
    
    //MARK: Annotation Functions
    
    @objc
    private func updateAnnotation() {
        saveAnnotationToRealm()
        toggleAnnotation()
    }
    
    @objc
    private func selectAnnotation() {
        guard let nearestAnnotation else { return }
        mapView.selectAnnotation(nearestAnnotation, animated: true)
    }
    
    @objc
    private func deselectAnnotation() {
        guard let nearestAnnotation else { return }
        mapView.deselectAnnotation(nearestAnnotation, animated: true)
    }
    
    private func saveAnnotationToRealm() {
        guard let nearestAnnotation = nearestAnnotation,
              let place = nearestAnnotation.place else { return }
        
        let task = PlaceRealm(
            title: place.title,
            subtitle: place.subtitle,
            category: place.category,
            address: place.address,
            town: place.town,
            image: place.image,
            url: place.url,
            detail: place.detail,
            isCreatedAt: Date()
        )
        
        repository.createItem(task)
    }
    
    private func toggleAnnotation() {
        guard let nearestAnnotation = nearestAnnotation else { return }
        
        mapView.removeAnnotation(nearestAnnotation)
        
        let visitedAnnotationView = VisitedPlaceAnnotationView(annotation: nearestAnnotation, reuseIdentifier: VisitedPlaceAnnotationView.reuseIdentifier)
        
        guard let visitedAnnotation = visitedAnnotationView.annotation else { return }
        
        mapView.addAnnotation(visitedAnnotation)
        
        placeAnnotations = placeAnnotations.filter { $0 !== nearestAnnotation }
        
        isArrivedToPlace = false
    }
    
    private func findNearestAnnotation(_ currentLocation: CLLocationCoordinate2D) -> PlaceAnnotation? {
        let annotations = placeAnnotations
        guard annotations.count > 0 else { return nil }
        
        var nearestAnnotation: PlaceAnnotation?
        var nearestDistance = Double.infinity
        
        let currentUserLocation = CLLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
        
        for annotation in annotations {
            let annotationLocation = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
            let distance = currentUserLocation.distance(from: annotationLocation)
            
            guard distance <= 60 else { continue }
            
            if distance < nearestDistance {
                nearestAnnotation = annotation
                nearestDistance = distance
            }
        }
        
        return nearestAnnotation
    }
    
    //MARK: GeoJSON
    
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
    
    //MARK: BaseView
    
    override func configureHierarchy() {
        view.addSubview(mapView)
    }
    
    override func setConstraints() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func configureMapView() {
        mapView.delegate = self
        mapView.register(PlaceAnnotationView.self, forAnnotationViewWithReuseIdentifier: PlaceAnnotationView.reuseIdentifier)
        mapView.register(VisitedPlaceAnnotationView.self, forAnnotationViewWithReuseIdentifier: PlaceAnnotationView.reuseIdentifier)
        
        mapView.mapType = .standard
        mapView.showsUserLocation = true
        mapView.showsCompass = true
        mapView.showsScale = true
        
        mapView.configureUserTrackingButton()
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
        
        if annotation is MKUserLocation { return nil }
        
        guard let annotation = annotation as? PlaceAnnotation,
              let title = annotation.title else { return nil }
        
        let data = repository.fetchByWord(word: title)
        
        if data.isEmpty {
            placeAnnotations.append(annotation)
            return PlaceAnnotationView(annotation: annotation, reuseIdentifier: PlaceAnnotationView.reuseIdentifier)
        } else {
            return VisitedPlaceAnnotationView(annotation: annotation, reuseIdentifier: VisitedPlaceAnnotationView.reuseIdentifier)
        }
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        guard isStampMapViewController(viewController: self) else { return }
        
        guard let nearestAnnotation = findNearestAnnotation(userLocation.coordinate) else { return }
        self.nearestAnnotation = nearestAnnotation
        
        let nearestAnnotationLocation = CLLocation(latitude: nearestAnnotation.coordinate.latitude, longitude: nearestAnnotation.coordinate.longitude)
        let currentUserLocation = CLLocation(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let nearestDistance = currentUserLocation.distance(from: nearestAnnotationLocation)
        
        if nearestDistance <= 15 && isArrivedToPlace == false {
            isArrivedToPlace = true
            presentPlaceArrivalView()
        } else if nearestDistance >= 45 && isArrivedToPlace == true {
            isArrivedToPlace = false
            dismiss(animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        guard isArrivedToPlace == true else { return }
        
        guard let nearestAnnotation,
              let annotation = annotation as? PlaceAnnotation,
              let title = annotation.title else { return }
        
        guard annotation === nearestAnnotation else { return }
        
        let data = repository.fetchByWord(word: title)
        
        if data.isEmpty { presentPlaceArrivalView() }
    }
}

//MARK: CLLocationManagerDelegate

extension StampMapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
            mapView.setRegion(region, animated: true)
        }
        locationManager.stopUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkDeviceLocationAuthorization()
    }
}
