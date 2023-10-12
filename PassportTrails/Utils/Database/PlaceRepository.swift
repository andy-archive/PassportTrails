//
//  PlaceRepository.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/10/12.
//

import Foundation
import RealmSwift

protocol PlaceRepositoryType: AnyObject {
    func fetchByDate() -> Results<PlaceRealm>
    func fetchByWord(word: String) -> Results<PlaceRealm>
    func createItem(_ item: PlaceRealm)
}

final class PlaceRepository: PlaceRepositoryType {

    private let realm = try! Realm()

    func checkSchemaVersion() {
        guard let fileURL = realm.configuration.fileURL else { return }

        do {
            let version = try schemaVersionAtURL(fileURL)
            print("Schema Version: \(version)")
        } catch {
            print(error)
        }
    }

    func fetchByDate() -> Results<PlaceRealm> {
        let data = realm.objects(PlaceRealm.self).sorted(byKeyPath: "isCreatedAt", ascending: false)
        return data
    }

    func fetchByWord(word: String) -> Results<PlaceRealm> {
        let data = realm.objects(PlaceRealm.self).where { place in
            place.title.contains(word)
        }
        return data
    }

    func createItem(_ item: PlaceRealm) {
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print(error)
        }
    }

    func deleteItem(_ item: PlaceRealm) {
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print(error)
        }
    }
}


