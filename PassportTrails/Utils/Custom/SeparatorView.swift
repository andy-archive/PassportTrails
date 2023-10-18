//
//  SeparatorView.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/10/19.
//

import UIKit

final class SeparatorView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        layer.backgroundColor = UIColor.systemGray3.cgColor
        heightAnchor.constraint(equalToConstant: Constants.Design.separatorWidth).isActive = true
    }
}
