//
//  StampListViewController.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/09/22.
//

import UIKit

final class StampListViewController: BaseViewController {
    
    private lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: .setCollectionViewLayout(numberOfItem: 3, sectionSpacing: 4, itemSpacing: 4))
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.topItem?.title = "스탬프 목록"
        navigationController?.navigationBar.prefersLargeTitles = true
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
}

//MARK: UICollectionViewDelegate, UICollectionViewDataSource

extension StampListViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StampListCollectionViewCell.reuseIdentifier, for: indexPath) as? StampListCollectionViewCell else { return UICollectionViewCell() }

        return cell
    }
}
