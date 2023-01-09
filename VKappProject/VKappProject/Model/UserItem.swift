// UserItem.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Информация о друзьях
final class UserItem: Object, Codable {
    /// Идентификатор
    @Persisted(primaryKey: true) var id: Int
    /// Имя
    @Persisted var firstName: String
    /// Фамилия
    @Persisted var lastName: String
    /// Фото
    @Persisted var photo: String
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo_100"
    }
}
