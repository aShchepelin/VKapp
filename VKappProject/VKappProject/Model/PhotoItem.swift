// PhotoItem.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Фото конкректного пользователя
final class PhotoItem: Object, Codable {
    /// Идентификатор фотографии
    @Persisted(primaryKey: true) var id: Int
    /// Идентификатор владельца
    @Persisted var ownerID: Int
    /// Массив фотографий разных размеров
    @Persisted var sizes = List<Size>()
    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
        case sizes
    }
}
