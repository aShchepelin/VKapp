// ParsData.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Парсинг запроса
final class ParseData: Operation {
    // MARK: - Public Properties

    var outputData: [GroupItem] = []

    // MARK: - Public Methods

    override func main() {
        guard let getDataOperation = dependencies.first as? GetDataOperation,
              let data = getDataOperation.data else { return }

        do {
            let response = try JSONDecoder().decode(Group.self, from: data)
            outputData = response.response.groups
        } catch {
            print(error.localizedDescription)
        }
    }
}
