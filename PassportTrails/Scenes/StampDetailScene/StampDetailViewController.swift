//
//  StampDetailViewController.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/10/18.
//

import UIKit
import RealmSwift

final class StampDetailViewController: BaseViewController {
    
    var isDetailed = false
    var place: PlaceRealm?
    
    private lazy var titleLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: Constants.FontSize.title)
        view.numberOfLines = 0
        view.textColor = Constants.Color.label
        return view
    }()
    
    private lazy var subtitleLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: Constants.FontSize.subtitle)
        view.numberOfLines = 0
        view.textColor = Constants.Color.secondaryLabel
        return view
    }()
    
    private lazy var dismissButton = {
        let view = UIButton()
        view.setImage(Constants.Image.downChevron, for: .normal)
        return view
    }()
    
    private lazy var stampImage = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private lazy var titleSeparator = {
        let view = SeparatorView()
        view.layer.backgroundColor = Constants.Color.separator
        return view
    }()
    
    private lazy var detailLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: Constants.FontSize.detail)
        view.numberOfLines = 3
        view.textColor = .label
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private lazy var detailButton = {
        let view = UIButton()
        view.setImage(Constants.Image.compactDownChevron, for: .normal)
        return view
    }()
    
    private lazy var detailSeparator = {
        let view = SeparatorView()
        return view
    }()
    
    private lazy var addressLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: Constants.FontSize.detail)
        view.numberOfLines = 0
        view.textColor = Constants.Color.label
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc
    private func dismissButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc
    private func detailLabelClicked(_ sender: UITapGestureRecognizer) {
        isDetailed.toggle()
        changeDetail()
    }
    
    @objc
    private func detailButtonClicked() {
        isDetailed.toggle()
        changeDetail()
    }
    
    private func changeDetail() {
        if isDetailed {
            detailButton.setImage(Constants.Image.compactUpChevron, for: .normal)
            detailLabel.numberOfLines = 0
        } else {
            detailButton.setImage(Constants.Image.compactDownChevron, for: .normal)
            detailLabel.numberOfLines = 3
        }
    }
    
    private func fetchStampImage(string: String) {
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
    
    private func fetchPlaceData() {
        guard let place else { return }
        
        titleLabel.text = place.title
        subtitleLabel.text = place.subtitle
        detailLabel.text = place.detail
        addressLabel.text = place.address
        
        self.fetchStampImage(string: place.image)
    }
    
    override func configureView() {
        super.configureView()
        
        fetchPlaceData()
        detailLabel.configureSpaceBetweenLines(lineSpacing: Constants.Design.lineSpacing)
        
        let detailLabelClicked = UITapGestureRecognizer(target: self, action: #selector(detailLabelClicked(_:)))
        
        dismissButton.addTarget(self, action: #selector(dismissButtonClicked), for: .touchUpInside)
        detailLabel.addGestureRecognizer(detailLabelClicked)
        detailButton.addTarget(self, action: #selector(detailButtonClicked), for: .touchUpInside)
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(dismissButton)
        view.addSubview(stampImage)
        view.addSubview(titleSeparator)
        view.addSubview(detailLabel)
        view.addSubview(detailButton)
        view.addSubview(detailSeparator)
        view.addSubview(addressLabel)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.Design.verticalConstant),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Design.horizontalConstant),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: dismissButton.trailingAnchor, constant: -Constants.Design.horizontalConstant),
        ])
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.Design.verticalConstant / 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Design.horizontalConstant),
            subtitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -Constants.Design.horizontalConstant)
        ])
        
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.Design.horizontalConstant),
            dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Design.horizontalConstant)
        ])
        
        stampImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stampImage.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: Constants.Design.verticalConstant),
            stampImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stampImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            stampImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3)
        ])
        
        titleSeparator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleSeparator.topAnchor.constraint(equalTo: stampImage.bottomAnchor, constant: Constants.Design.verticalConstant),
            titleSeparator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Design.horizontalConstant),
            titleSeparator.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -Constants.Design.horizontalConstant),
            titleSeparator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailLabel.topAnchor.constraint(equalTo: titleSeparator.bottomAnchor, constant: Constants.Design.verticalConstant),
            detailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Design.horizontalConstant),
            detailLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -Constants.Design.horizontalConstant)
        ])
        
        detailButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailButton.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: Constants.Design.verticalConstant / 2),
            detailButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        detailSeparator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailSeparator.topAnchor.constraint(equalTo: detailButton.bottomAnchor, constant: Constants.Design.verticalConstant / 2),
            detailSeparator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Design.horizontalConstant),
            detailSeparator.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -Constants.Design.horizontalConstant),
            detailSeparator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: detailSeparator.bottomAnchor, constant: Constants.Design.verticalConstant),
            addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Design.horizontalConstant),
            addressLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -Constants.Design.horizontalConstant)
        ])
    }
}
