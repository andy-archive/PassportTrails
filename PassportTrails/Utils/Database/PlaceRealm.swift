//
//  PlaceRealm.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/10/11.
//

import Foundation
import RealmSwift

final class PlaceRealm: Object {
    
    @Persisted(primaryKey: true) var _id: String = UUID().uuidString
    
    @Persisted var title: String
    @Persisted var subtitle: String
    @Persisted var category: String
    @Persisted var address: String
    @Persisted var town: String
    @Persisted var image: String
    @Persisted var url: String
    @Persisted var detail: String
    @Persisted var isCreatedAt: Date
    
    convenience init(_id: String = UUID().uuidString, title: String, subtitle: String, category: String, address: String, town: String, image: String, url: String, detail: String, isCreatedAt: Date) {
        self.init()
        
        self._id = _id
        self.title = title
        self.subtitle = subtitle
        self.category = category
        self.address = address
        self.town = town
        self.image = image
        self.url = url
        self.detail = detail
        self.isCreatedAt = isCreatedAt
    }
}
