//
//  StampDetailViewController.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/10/18.
//

import UIKit
import RealmSwift

final class StampDetailViewController: BaseViewController {
    
    var place: PlaceRealm?
    
    private lazy var titleLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: Constants.FontSize.title)
        view.numberOfLines = 0
        view.textColor = .label
        return view
    }()
    
    private lazy var subtitleLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: Constants.FontSize.subtitle)
        view.numberOfLines = 0
        view.textColor = .secondaryLabel
        return view
    }()
    
    private lazy var titleSeparator = {
        let view = SeparatorView()
        view.layer.backgroundColor = UIColor.systemGray3.cgColor
        return view
    }()
    
    private lazy var detailLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: Constants.FontSize.detail)
        view.numberOfLines = 3
        view.textColor = .label
        return view
    }()
    
    private lazy var detailButton = {
        let view = UIButton()
        let buttonImage = UIImage(systemName: "chevron.down")?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
        view.setImage(buttonImage, for: .normal)
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
        view.textColor = .label
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc
    func detailButtonClicked() {
        detailButton.isHidden = true
        detailLabel.numberOfLines = 0
        
        detailSeparator.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: Constants.Design.verticalConstant / 2).isActive = true
    }
    
    private func fetchPlaceData() {
        guard let place else { return }
        
        titleLabel.text = place.title
        subtitleLabel.text = place.subtitle
        detailLabel.text = place.detail
        addressLabel.text = place.address
    }
    
    override func configureView() {
        super.configureView()
        
        fetchPlaceData()
        detailLabel.configureSpaceBetweenLines(lineSpacing: Constants.Design.lineSpacing)
        detailButton.addTarget(self, action: #selector(detailButtonClicked), for: .touchUpInside)
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(titleSeparator)
        view.addSubview(detailLabel)
        view.addSubview(detailButton)
        view.addSubview(detailSeparator)
        view.addSubview(addressLabel)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        let horizontalConstant = view.frame.width * Constants.Design.horizontalRatio
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.Design.verticalConstant),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalConstant),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -horizontalConstant),
        ])
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.Design.verticalConstant / 2),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalConstant),
            subtitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -horizontalConstant)
        ])
        
        titleSeparator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleSeparator.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: Constants.Design.verticalConstant / 2),
            titleSeparator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalConstant),
            titleSeparator.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -horizontalConstant),
            titleSeparator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: Constants.Design.verticalConstant),
            detailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalConstant),
            detailLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -horizontalConstant)
        ])
        
        detailButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailButton.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: Constants.Design.verticalConstant / 4),
            detailButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        detailSeparator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailSeparator.topAnchor.constraint(equalTo: detailButton.bottomAnchor, constant: Constants.Design.verticalConstant / 4),
            detailSeparator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalConstant),
            detailSeparator.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -horizontalConstant),
            detailSeparator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: detailSeparator.bottomAnchor, constant: Constants.Design.verticalConstant / 2),
            addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalConstant),
            addressLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -horizontalConstant)
        ])
    }
}
