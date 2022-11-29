// PhotoItem.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Фото конкректного пользователя
final class PhotoItem: Object, Codable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var ownerID: Int
    @Persisted var sizes = List<Size>()
    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
        case sizes
    }
}
