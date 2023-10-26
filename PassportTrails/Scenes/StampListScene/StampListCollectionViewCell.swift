//
//  StampListCollectionViewCell.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/10/13.
//

import UIKit
import Kingfisher

class StampListCollectionViewCell: BaseCollectionViewCell {
    
    private let stampStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.spacing = 6
        return view
    }()
    
    private let stampImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let titleLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 12)
        view.textColor = .label
        view.textAlignment = .center
        view.numberOfLines = 2
        return view
    }()
    
    func fetchPlaceData(place: PlaceRealm) {
        titleLabel.text = place.title
        stampImageView.fetchStampImage(urlString: place.image, width: Constants.Screen.width * Constants.Design.listStampRatio, height: Constants.Screen.height * Constants.Design.listStampRatio)
    }
    
    override func configureView() {
        super.configureView()
    }
    
    override func configureHierarchy() {
        contentView.addSubview(stampStackView)
        stampStackView.addArrangedSubview(stampImageView)
        stampStackView.addArrangedSubview(titleLabel)
    }
    
    override func setConstraints() {
        stampStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stampStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stampStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
        
        stampImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stampImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: Constants.Design.listStampRatio),
            stampImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: Constants.Design.listStampRatio),
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        stampImageView.image = nil
    }
}
