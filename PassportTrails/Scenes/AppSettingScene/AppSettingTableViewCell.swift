//
//  AppSettingTableViewCell.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/10/27.
//

import UIKit

class AppSettingTableViewCell: BaseTableViewCell {
    
    lazy var titleLabel = {
        let view = UILabel()
        view.textColor = Constants.Color.label
        view.backgroundColor = Constants.Color.secondaryGroupedBackground
        view.font = .systemFont(ofSize: Constants.FontSize.subtitle)
        return view
    }()
    
    override func configureView() {
        super.configureView()
    }
    
    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
    }
    
    override func setConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

