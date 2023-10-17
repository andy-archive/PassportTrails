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
        let view = UICollectionView(frame: .zero, collectionViewLayout: .setCollectionViewLayout(numberOfItem: 2, sectionSpacing: 0, itemSpacing: 0))
        return view
    }()
    
    private let repository = PlaceRepository()
    private let realm = try! Realm()
    private var tasks: Results<PlaceRealm>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.title = "스탬프 목록"
        
        tasks = repository.fetchByDate()
        NotificationCenter.default.addObserver(self, selector: #selector(fetchStampImage), name: NSNotification.Name.deselectAnnotation, object: nil)
    }
    
    override func configureView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(StampListCollectionViewCell.self, forCellWithReuseIdentifier: StampListCollectionViewCell.reuseIdentifier)
    }
    
    override func configureHierarchy() {
        view.addSubview(collectionView)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    @objc
    private func fetchStampImage() {
        collectionView.reloadData()
    }
}

//MARK: UICollectionViewDelegate, UICollectionViewDataSource

extension StampListViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StampListCollectionViewCell.reuseIdentifier, for: indexPath) as? StampListCollectionViewCell else { return UICollectionViewCell() }
        
        let row = tasks[indexPath.row]
        
        cell.fetchStampImage(string: row.image)
        cell.fetchStampTitle(string: row.title)
        
        return cell
    }
}
