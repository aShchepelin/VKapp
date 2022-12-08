//  SaveRealmOperation.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Сохранение распарсенных данных в Realm
final class SaveRealmOperation: Operation {
    // MARK: - Public Properties

    let realmService = RealmService()

    // MARK: - Public Methods

    override func main() {
        guard let parseData = dependencies.first as? ParseData else { return }
        realmService.saveData(parseData.outputData)
    }
}
