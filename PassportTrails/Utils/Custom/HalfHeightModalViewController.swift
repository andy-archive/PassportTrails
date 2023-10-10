//
//  HalfHeightModalViewController.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/10/10.
//

import UIKit

class HalfHeightModalViewController: BaseViewController {
    
    private let titleLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 30)
        view.numberOfLines = 1
        return view
    }()
    
    private let subtitleLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 20)
        view.textColor = .systemBlue
        view.numberOfLines = 1
        return view
    }()
    
    private let getButton = {
        let view = UIButton()
        view.backgroundColor = .systemBlue
        view.titleLabel?.font = .boldSystemFont(ofSize: 20)
        view.setTitleColor(.white, for: .normal)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        
        view.backgroundColor = .white
        
        titleLabel.text = "🎉 장소에 도착했습니다 🎉"
        
        subtitleLabel.text = "아래 버튼을 눌러 스탬프를 받으세요 👇"
        
        getButton.setTitle("스탬프 받기", for: .normal)
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(getButton)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            subtitleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        getButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            getButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            getButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            getButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            getButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
