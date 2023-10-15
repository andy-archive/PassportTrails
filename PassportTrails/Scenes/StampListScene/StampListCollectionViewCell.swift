//
//  StampListCollectionViewCell.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/10/13.
//

import UIKit

class StampListCollectionViewCell: BaseCollectionViewCell {
    
    private let stampImage = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
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
    
    func fetchStampImage(string: String) {
        if string.isEmpty {
            self.stampImage.image = UIImage(systemName: "building.columns")
        }
        
        guard let url = URL(string: string) else { return }
        
        url.fetchImage { [weak self] image in
            guard let image else { return }
            
            DispatchQueue.main.async {
                self?.stampImage.image = image
            }
        }
    }
}
