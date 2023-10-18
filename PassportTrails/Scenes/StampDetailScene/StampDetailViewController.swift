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
        view.font = .boldSystemFont(ofSize: 30)
        view.numberOfLines = 2
        view.textColor = .label
        return view
    }()
    
    private lazy var subtitleLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15)
        view.numberOfLines = 2
        view.textColor = .label
        return view
    }()
    
    private lazy var separatorLine = {
        let view = UIView()
        view.layer.backgroundColor = UIColor.systemGray3.cgColor
        return view
    }()
    
    private lazy var detailLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15)
        view.numberOfLines = 3
        view.textColor = .label
        return view
    }()
    
    private lazy var addressLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15)
        view.numberOfLines = 2
        view.textColor = .label
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        
        guard let place else { return }
        
        titleLabel.text = place.title
        subtitleLabel.text = place.subtitle
        detailLabel.text = (place.detail)
        addressLabel.text = (place.address)
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(separatorLine)
        view.addSubview(detailLabel)
        view.addSubview(addressLabel)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        let horizontalConstantRatio = 0.08
        let horizontalConstant = view.frame.width * horizontalConstantRatio
        let verticalConstant: CGFloat = 16.0
        let separatorWidth: CGFloat = 1.0
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: verticalConstant),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalConstant),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -horizontalConstant),
        ])
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: verticalConstant / 2),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalConstant),
            subtitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -horizontalConstant)
        ])
        
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            separatorLine.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: verticalConstant / 2),
            separatorLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalConstant),
            separatorLine.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -horizontalConstant),
            separatorLine.heightAnchor.constraint(equalToConstant: separatorWidth),
            separatorLine.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: verticalConstant),
            detailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalConstant),
            detailLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -horizontalConstant)
        ])
        
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: verticalConstant),
            addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalConstant),
            addressLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -horizontalConstant)
        ])
    }
}
