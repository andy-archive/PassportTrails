//
//  StampMapViewController.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/09/23.
//

import UIKit
import MapKit
import CoreLocation
import CoreLocationUI
import RealmSwift

final class StampMapViewController: BaseViewController {
    
    private let locationManager = CLLocationManager()
    private let mapView = MKMapView()
    
    private var placeAnnotations = [PlaceAnnotation]()
    private var nearestAnnotation: PlaceAnnotation?
    private var isArrivedToPlace = false
    
    private let repository = PlaceRepository()
    private let realm = try! Realm()
    
    private lazy var radarView = {
        let view = UIView()
        view.backgroundColor = Constants.Color.buttonBackground.withAlphaComponent(0.8)
        view.layer.cornerRadius = Constants.Button.cornerRadius
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let labelStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private lazy var distanceLabel = {
        let view = UILabel()
        view.textColor = Constants.Color.buttonTitle
        view.font = .boldSystemFont(ofSize: Constants.FontSize.title)
        view.textAlignment = .left
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var placeTitleLabel = {
        let view = UILabel()
        view.textColor = Constants.Color.buttonTitle
        view.font = .boldSystemFont(ofSize: Constants.FontSize.buttonTitle)
        view.textAlignment = .left
        view.lineBreakStrategy = .hangulWordPriority
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var directionButton = {
        let view = UIButton()
        let sizeConfig = UIImage.SymbolConfiguration(pointSize: Constants.CLLocationButton.height, weight: .medium, scale: .medium)
        let colorConfig = UIImage.SymbolConfiguration(paletteColors: [Constants.Color.buttonTitle, Constants.Color.buttonBackground.withAlphaComponent(0.8)])
        let config = sizeConfig.applying(colorConfig)
        view.setImage(UIImage(systemName: "arrow.triangle.turn.up.right.circle.fill", withConfiguration: config), for: .normal)
        view.addTarget(self, action: #selector(directionButtonClicked), for: .touchUpInside)
        return view
    }()
    
    private lazy var currentLocationButton = {
        let buttonRect = CGRect(x: 0, y: 0, width: Constants.CLLocationButton.height, height: Constants.CLLocationButton.height)
        let view = CLLocationButton(frame: buttonRect)
        view.icon = .arrowFilled
        view.tintColor = Constants.Color.buttonBackground
        view.backgroundColor = Constants.Color.buttonTitle
        view.cornerRadius = Constants.CLLocationButton.height / 2
        view.addTarget(self, action: #selector(currentLocationClicked), for: .touchUpInside)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.masksToBounds = false
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchGeoJson(fileName: "place")
        
        configureLocationManager()
        configureMapView()
        configureRadarView()
        configureNotification()
        
        navigationController?.navigationBar.isHidden = true
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
    
    //MARK: Button Actions
    
    @objc
    private func directionButtonClicked() {
        guard let nearestAnnotation else { return }
        let userlocation = mapView.userLocation
        
        let middleCoordinate = userlocation.coordinate.showMiddleCoordinate(between: nearestAnnotation.coordinate)
        var distance = userlocation.showDistance(from: nearestAnnotation)
        
        if distance <= Constants.Distance.minimumDirectionAltitude { distance = Constants.Distance.minimumDirectionAltitude }
        
        let altitude = distance * Constants.Distance.directionAltitudeRatio
        
        let camera = MKMapCamera(lookingAtCenter: middleCoordinate, fromEyeCoordinate: userlocation.coordinate, eyeAltitude: altitude)
        camera.pitch = 0
        mapView.setCamera(camera, animated: true)
    }
    
    @objc
    private func currentLocationClicked() {
        self.locationManager.startUpdatingLocation()
    }
    
    @objc
    private func radarViewClicked(_ sender: UITapGestureRecognizer) {
        guard let nearestAnnotation else { return }
        mapView.showLocationOnCenter(coordinate: nearestAnnotation.coordinate)
    }
    
    private func configureRadarView() {
        let radarViewGesture = UITapGestureRecognizer(target: self, action: #selector(radarViewClicked(_:)))
        let labelStackViewGesture = UITapGestureRecognizer(target: self, action: #selector(radarViewClicked(_:)))
        radarView.addGestureRecognizer(radarViewGesture)
        labelStackView.addGestureRecognizer(labelStackViewGesture)
    }
    
    private func configureNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateAnnotation), name: NSNotification.Name.stampButtonClicked, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(selectAnnotation), name: NSNotification.Name.selectAnnotation, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deselectAnnotation), name: NSNotification.Name.deselectAnnotation, object: nil)
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
            
            guard distance <= Constants.Distance.isNearbyPlace else { continue }
            
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
        view.addSubview(radarView)
        view.addSubview(labelStackView)
        
        mapView.addSubview(directionButton)
        mapView.addSubview(currentLocationButton)
        
        labelStackView.addArrangedSubview(distanceLabel)
        labelStackView.addArrangedSubview(placeTitleLabel)
    }
    
    override func setConstraints() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        radarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            radarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.MKButton.verticalConstant),
            radarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.MKButton.horizontalConstant),
            radarView.heightAnchor.constraint(equalTo: labelStackView.heightAnchor, multiplier: Constants.RadarView.heightRatio),
            radarView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constants.RadarView.widthRatio)
        ])
        
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelStackView.leadingAnchor.constraint(equalTo: radarView.leadingAnchor, constant: Constants.MKButton.horizontalConstant),
            labelStackView.trailingAnchor.constraint(lessThanOrEqualTo: radarView.trailingAnchor, constant: -Constants.MKButton.horizontalConstant),
            labelStackView.centerYAnchor.constraint(equalTo: radarView.centerYAnchor)
        ])
        
        directionButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            directionButton.topAnchor.constraint(equalTo: mapView.safeAreaLayoutGuide.topAnchor, constant: Constants.MKButton.verticalConstant),
            directionButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -Constants.MKButton.horizontalConstant / 2),
        ])
        
        currentLocationButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currentLocationButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -Constants.MKButton.horizontalConstant),
            currentLocationButton.bottomAnchor.constraint(equalTo: mapView.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.Sheet.placeArrivalHeight),
            currentLocationButton.heightAnchor.constraint(equalToConstant: Constants.CLLocationButton.height),
            currentLocationButton.widthAnchor.constraint(equalToConstant: Constants.CLLocationButton.height)
        ])
    }
    
    private func configureMapView() {
        mapView.delegate = self
        mapView.register(PlaceAnnotationView.self, forAnnotationViewWithReuseIdentifier: PlaceAnnotationView.reuseIdentifier)
        mapView.register(VisitedPlaceAnnotationView.self, forAnnotationViewWithReuseIdentifier: PlaceAnnotationView.reuseIdentifier)
        
        mapView.mapType = .standard
        mapView.showsUserLocation = true
        mapView.showsCompass = false
        
        mapView.configureCompassButton()
    }
    
    private func configureLocationManager() {
        locationManager.delegate = self
        
        checkDeviceLocationAuthorization()
    }
    
    //MARK: LocationAuthorization
    
    private func showLocationSettingAlert() {
        let alert = UIAlertController(title: "위치 권한 설정", message: "주변의 일상 공간을 찾기 위해서 위치 권한이 필요합니다.\n'설정 → 개인 정보 보호'에서\n위치를 허용해 주세요.", preferredStyle: .alert)
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
        
        guard let nearestAnnotation = findNearestAnnotation(userLocation.coordinate) else {
            distanceLabel.text?.removeAll()
            placeTitleLabel.showNotNearbyPlace()
            directionButton.isHidden = true
            return
        }
        
        self.nearestAnnotation = nearestAnnotation
        
        let nearestDistance = userLocation.showDistance(from: nearestAnnotation)
        
        guard let annotationTitle = nearestAnnotation.title else { return }
        
        distanceLabel.showDistanceInMeter(distance: nearestDistance)
        placeTitleLabel.showPlaceTitle(title: annotationTitle)
        directionButton.isHidden = false
        
        if nearestDistance <= Constants.Distance.didArrivePlace && isArrivedToPlace == false {
            isArrivedToPlace = true
            presentPlaceArrivalView()
        } else if nearestDistance >= Constants.Distance.willLeavePlace && isArrivedToPlace == true {
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
            mapView.showLocationOnCenter(coordinate: coordinate)
        }
        locationManager.stopUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkDeviceLocationAuthorization()
    }
}
