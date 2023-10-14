//
//  StampListCollectionViewCell.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/10/13.
//

import UIKit

class StampListCollectionViewCell: BaseCollectionViewCell {
    
    private let stampImage = {
        let view = UIImageView(image: UIImage(systemName: "building.columns"))
        return view
    }()
    
    override func configureView() {
        super.configureView()
        
        contentView.backgroundColor = .systemGray6
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 10
        
        stampImage.clipsToBounds = true
        stampImage.layer.cornerRadius = 10
    }
    
    override func configureHierarchy() {
        contentView.addSubview(stampImage)
    }
    
    override func setConstraints() {
        stampImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stampImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            stampImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stampImage.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor),
            stampImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
