//
//  PlaceArrivalViewController.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/10/10.
//

import UIKit

class PlaceArrivalViewController: BaseViewController {
    
    private let titleLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: Constants.FontSize.title)
        view.numberOfLines = 1
        return view
    }()
    
    private let subtitleLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: Constants.FontSize.subtitle)
        view.textColor = .systemBlue
        view.numberOfLines = 1
        return view
    }()
    
    private let stampButton = {
        let view = UIButton()
        view.backgroundColor = Constants.Color.buttonBackground
        view.titleLabel?.font = .boldSystemFont(ofSize: Constants.FontSize.buttonTitle)
        view.setTitleColor(Constants.Color.buttonTitle, for: .normal)
        view.layer.cornerRadius = Constants.Button.cornerRadius
        view.layer.masksToBounds = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.post(name: NSNotification.Name.selectAnnotation, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.post(name: NSNotification.Name.deselectAnnotation, object: nil)
    }
    
    @objc
    private func stampButtonClicked() {
        NotificationCenter.default.post(name: NSNotification.Name.stampButtonClicked, object: nil)
        NotificationCenter.default.post(name: NSNotification.Name.reloadStampCollectionView, object: nil)
        dismiss(animated: true)
    }
    
    //MARK: BaseView
    
    override func configureView() {
        super.configureView()
        
        titleLabel.text = Constants.Text.arrivedTitle
        
        subtitleLabel.text = Constants.Text.arrivedSubtitle
        
        stampButton.setTitle(Constants.Text.arrivedButtonTitle, for: .normal)
        stampButton.addTarget(self, action: #selector(stampButtonClicked), for: .touchUpInside)
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(stampButton)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -Constants.Design.verticalConstant),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(greaterThanOrEqualTo: titleLabel.bottomAnchor, constant: Constants.Design.verticalConstant),
            subtitleLabel.bottomAnchor.constraint(equalTo: stampButton.topAnchor, constant: -Constants.Design.verticalConstant / 2),
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        stampButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stampButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Design.horizontalConstant),
            stampButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Design.horizontalConstant),
            stampButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.Design.verticalConstant / 2),
            stampButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stampButton.heightAnchor.constraint(equalToConstant: Constants.Button.height)
        ])
    }
}
