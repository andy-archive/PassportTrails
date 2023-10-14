//
//  ReusableViewProtocol.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/10/13.
//

import UIKit

protocol ReusableViewProtocol: AnyObject {
    static var reuseIdentifier: String { get }
}

extension UICollectionViewCell: ReusableViewProtocol {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}
