// RealmService.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Сервис для сохранения данных в кэш
class RealmService {
    func saveDataToRealm<T: Object>(_ info: [T]) {
        do {
            let configuration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: configuration)
            try realm.write {
                realm.add(info, update: .modified)
            }
        } catch {
            print(error)
        }
    }
}
