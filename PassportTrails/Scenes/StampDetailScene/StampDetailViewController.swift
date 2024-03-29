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
    
    private lazy var scrollView = {
        let view = UIScrollView()
        view.isScrollEnabled = true
        view.backgroundColor = Constants.Color.background
        return view
    }()
    
    private let contentView = {
        let view = UIView()
        view.backgroundColor = Constants.Color.background
        return view
    }()
    
    private lazy var titleLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: Constants.FontSize.title)
        view.numberOfLines = 0
        view.textColor = Constants.Color.label
        view.lineBreakStrategy = .hangulWordPriority
        return view
    }()
    
    private lazy var subtitleLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: Constants.FontSize.subtitle)
        view.numberOfLines = 0
        view.textColor = Constants.Color.secondaryLabel
        view.lineBreakStrategy = .hangulWordPriority
        return view
    }()
    
    private lazy var dismissButton = {
        let view = UIButton()
        let sizeConfig = UIImage.SymbolConfiguration(pointSize: Constants.FontSize.title, weight: .medium, scale: .medium)
        let colorConfig = UIImage.SymbolConfiguration(hierarchicalColor: UIColor.tertiaryLabel)
        let config = sizeConfig.applying(colorConfig)
        view.setImage(UIImage(systemName: "x.circle.fill", withConfiguration: config), for: .normal)
        return view
    }()
    
    private lazy var stampImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
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
        view.lineBreakStrategy = .hangulWordPriority
        return view
    }()
    
    private lazy var detailButton = {
        let view = UIButton()
        view.setImage(Constants.Image.downChevron, for: .normal)
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
            detailButton.setImage(Constants.Image.upChevron, for: .normal)
            detailLabel.numberOfLines = 0
        } else {
            detailButton.setImage(Constants.Image.downChevron, for: .normal)
            detailLabel.numberOfLines = 3
        }
    }
    
    private func fetchPlaceData() {
        guard let place else { return }
        
        titleLabel.text = place.title
        subtitleLabel.text = place.subtitle
        detailLabel.text = place.detail
        addressLabel.text = place.address
        
        stampImageView.fetchStampImage(urlString: place.image, width: Constants.Screen.width * Constants.Design.listStampRatio, height: Constants.Screen.height * Constants.Design.listStampRatio)
    }
    
    override func configureView() {
        super.configureView()
        
        fetchPlaceData()
        detailLabel.configureSpaceBetweenLines(lineSpacing: Constants.Design.lineSpacing)
        
        dismissButton.addTarget(self, action: #selector(dismissButtonClicked), for: .touchUpInside)
        detailButton.addTarget(self, action: #selector(detailButtonClicked), for: .touchUpInside)
        
        let detailLabelTapGesture = UITapGestureRecognizer(target: self, action: #selector(detailLabelClicked(_:)))
        detailLabel.addGestureRecognizer(detailLabelTapGesture)
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(dismissButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(stampImageView)
        contentView.addSubview(titleSeparator)
        contentView.addSubview(detailLabel)
        contentView.addSubview(detailButton)
        contentView.addSubview(detailSeparator)
        contentView.addSubview(addressLabel)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),//constant: -Constants.Design.verticalConstant),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
        
        ///MARK: contentView scroll
        let contentViewHeight = contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
        contentViewHeight.priority = .defaultLow
        contentViewHeight.isActive = true
        
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Constants.Design.verticalConstant),
            dismissButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Design.horizontalConstant),
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Constants.Design.verticalConstant),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Design.horizontalConstant),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: dismissButton.leadingAnchor, constant: -Constants.Design.horizontalConstant),
        ])
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.Design.verticalConstant / 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Design.horizontalConstant),
            subtitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: dismissButton.trailingAnchor, constant: -Constants.Design.horizontalConstant)
        ])
        
        stampImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stampImageView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: Constants.Design.verticalConstant),
            stampImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stampImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: Constants.Design.detailStampRatio),
            stampImageView.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: Constants.Design.detailStampRatio)
        ])
        
        titleSeparator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleSeparator.topAnchor.constraint(equalTo: stampImageView.bottomAnchor, constant: Constants.Design.verticalConstant),
            titleSeparator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Design.horizontalConstant),
            titleSeparator.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -Constants.Design.horizontalConstant),
            titleSeparator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailLabel.topAnchor.constraint(equalTo: titleSeparator.bottomAnchor, constant: Constants.Design.verticalConstant),
            detailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Design.horizontalConstant),
            detailLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -Constants.Design.horizontalConstant)
        ])
        
        detailButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailButton.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: Constants.Design.verticalConstant / 2),
            detailButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        detailSeparator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailSeparator.topAnchor.constraint(equalTo: detailButton.bottomAnchor, constant: Constants.Design.verticalConstant / 2),
            detailSeparator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Design.horizontalConstant),
            detailSeparator.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -Constants.Design.horizontalConstant),
            detailSeparator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: detailSeparator.bottomAnchor, constant: Constants.Design.verticalConstant),
            addressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Design.horizontalConstant),
            addressLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -Constants.Design.horizontalConstant),
            addressLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.Design.verticalConstant)
        ])
    }
}
