// PhotoItem.swift
// Copyright © RoadMap. All rights reserved.

/// Фото конкректного пользователя
struct PhotoItem: Codable {
    let ownerID: Int
    let sizes: [Size]

    enum CodingKeys: String, CodingKey {
        case ownerID = "owner_id"
        case sizes
    }
}
