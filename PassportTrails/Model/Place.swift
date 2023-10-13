//
//  Place.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/10/05.
//

import Foundation

struct Place: Decodable {
    let title: String
    let subtitle: String
    let category: String
    let address: String
    let town: String
    let image: String
    let url: String
    let detail: String
}
