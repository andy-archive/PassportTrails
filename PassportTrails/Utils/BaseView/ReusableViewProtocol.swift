//
//  ReusableViewProtocol.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/10/13.
//

import UIKit
import MapKit

protocol ReusableViewProtocol: AnyObject {
    static var reuseIdentifier: String { get }
}

extension MKAnnotationView: ReusableViewProtocol {
    public static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
}

extension UICollectionViewCell: ReusableViewProtocol {
    public static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
}

extension UITableViewCell: ReusableViewProtocol {
    public static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
}

