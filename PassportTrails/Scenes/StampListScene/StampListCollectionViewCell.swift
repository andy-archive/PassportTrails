//
//  StampListCollectionViewCell.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/10/13.
//

import UIKit

class StampListCollectionViewCell: BaseCollectionViewCell {
    
    private let stampStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.spacing = 6
        return view
    }()
    
    private let stampImage = {
        let view = UIImageView()
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
    
    private let cloverLabel = {
        let view = UILabel()
        view.text = "🍀"
        return view
    }()
    
    override func configureView() {
        super.configureView()
        
        contentView.backgroundColor = .systemGray6.withAlphaComponent(0.5)
        contentView.clipsToBounds = true
        contentView.layer.borderColor = UIColor.systemGray4.cgColor
        contentView.layer.borderWidth = 0.5
    }
    
    override func configureHierarchy() {
        contentView.addSubview(stampStackView)
        contentView.addSubview(cloverLabel)
        
        stampStackView.addArrangedSubview(stampImage)
        stampStackView.addArrangedSubview(titleLabel)
    }
    
    override func setConstraints() {
        stampStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stampStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stampStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
        
        stampImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stampImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7),
            stampImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7),
            
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let cloverConstant = contentView.frame.size.width / 15
        
        cloverLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cloverLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: cloverConstant),
            cloverLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: cloverConstant),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stampImage.image = nil
    }
    
    func fetchStampImage(string: String) {
        if string.isEmpty {
            let leafImage = UIImage(systemName: "leaf.circle")
            
            DispatchQueue.main.async {
                self.stampImage.image = leafImage?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
            }
        }
        
        guard let url = URL(string: string) else { return }
        
        url.fetchImage { [weak self] image in
            guard let image,
                  let stampImage = image.roundedImageWithGloomFilter()
            else { return }
            
            DispatchQueue.main.async {
                self?.stampImage.image = stampImage
            }
        }
    }
    
    func fetchStampTitle(string: String) {
        if string.isEmpty {
            titleLabel.text = "제목이 없습니다"
        }
        
        titleLabel.text = string
    }
}
