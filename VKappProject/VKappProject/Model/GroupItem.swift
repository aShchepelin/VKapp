// GroupItem.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Информация о группах
final class GroupItem: Object, Codable {
    /// Идентификатор
    @Persisted(primaryKey: true) var id: Int
    /// Название группы
    @Persisted var name: String
    /// Аватарка группы
    @Persisted var photo: String
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo = "photo_100"
    }
}
