//
//  StampListViewController.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/09/22.
//

import UIKit
import RealmSwift

final class StampListViewController: BaseViewController {
    
    private lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: .setCollectionViewLayout(numberOfItem: Constants.Cell.numberOfItem, sectionSpacing: Constants.Cell.sectionSpacing, itemSpacing: Constants.Cell.itemSpacing))
        return view
    }()
    
    private let repository = PlaceRepository()
    private var tasks: Results<PlaceRealm>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasks = repository.fetchByDate()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadStampCollectionView), name: NSNotification.Name.reloadStampCollectionView, object: nil)
    }
    
    @objc
    private func reloadStampCollectionView() {
        collectionView.reloadData()
    }
    
    override func configureView() {
        navigationController?.navigationBar.topItem?.title = Constants.Text.NavigationBar.stampListTitle
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(StampListCollectionViewCell.self, forCellWithReuseIdentifier: StampListCollectionViewCell.reuseIdentifier)
    }
    
    override func configureHierarchy() {
        view.addSubview(collectionView)
    }
    
    override func setConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

//MARK: UICollectionViewDelegate, UICollectionViewDataSource

extension StampListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StampListCollectionViewCell.reuseIdentifier, for: indexPath) as? StampListCollectionViewCell else { return UICollectionViewCell() }
        
        let place = tasks[indexPath.row]
        
        cell.fetchPlaceData(place: place)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let place = tasks[indexPath.row]
        
        presentStampDetailView(place: place)
    }
}
