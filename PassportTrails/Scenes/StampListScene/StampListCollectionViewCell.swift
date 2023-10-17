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
        
        contentView.backgroundColor = .systemGray6.withAlphaComponent(0.5)
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 10
    }
    
    override func configureHierarchy() {
        contentView.addSubview(stampImage)
    }
    
    override func setConstraints() {
        stampImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stampImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stampImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stampImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7),
            stampImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7),
            
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: stampImage.bottomAnchor, constant: 4),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -4),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stampImage.image = nil
    }
    
    func fetchStampImage(string: String) {
        if string.isEmpty {
            DispatchQueue.main.async {
                self.stampImage.image = UIImage(systemName: "leaf")
            }
        }
        
        guard let url = URL(string: string) else { return }
        
        url.fetchImage { [weak self] image in
            guard let image,
                  let stampImage = image.roundedImageWithFilter()
            else { return }
            
            DispatchQueue.main.async {
                self?.stampImage.image = stampImage
            }
        }
    }
}
