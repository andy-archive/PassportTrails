//
//  BaseViewController.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/09/26.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureHierarchy()
        setConstraints()
    }
    
    func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    func configureHierarchy() { }
    
    func setConstraints() { }
}
