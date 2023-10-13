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
    
    private let stampButton = {
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
        dismiss(animated: true)
    }
    
    //MARK: BaseView
    
    override func configureView() {
        super.configureView()
        
        titleLabel.text = "🎉 장소에 도착했습니다 🎉"
        
        subtitleLabel.text = "아래 버튼을 눌러 스탬프를 받으세요 👇"
        
        stampButton.setTitle("스탬프 받기", for: .normal)
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
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            subtitleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        stampButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stampButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            stampButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stampButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stampButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stampButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
