// GroupItem.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Информация о группах
final class GroupItem: Object, Codable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var photo: String
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo = "photo_100"
    }
}
