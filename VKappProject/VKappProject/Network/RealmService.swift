// RealmService.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Сервис для работы с Realm
final class RealmService {
    // MARK: - Private Property

    private let configuration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)

    // MARK: - Public Methods

    func saveData<T: Object>(_ info: [T]) {
        do {
            let realm = try Realm(configuration: configuration)
            try realm.write {
                realm.add(info, update: .modified)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    func getData<T: Object>(
        _ type: T.Type,
        config: Realm.Configuration = Realm.Configuration.defaultConfiguration
    ) -> Results<T>? {
        do {
            let realm = try Realm(configuration: configuration)
            return realm.objects(type)
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
