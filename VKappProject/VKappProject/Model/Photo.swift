// Photo.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Фото
struct Photo: Decodable {
    let response: ResponsePhoto
}

/// Фотографии пользователей
struct ResponsePhoto: Codable {
    let photos: [PhotoItem]

    enum CodingKeys: String, CodingKey {
        case photos = "items"
    }
}

/// Фото конкректного пользователя
struct PhotoItem: Codable {
    let ownerID: Int
    let sizes: [Size]

    enum CodingKeys: String, CodingKey {
        case ownerID = "owner_id"
        case sizes
    }
}

/// Параметры фото
final class Size: Object, Codable {
    @objc dynamic var url: String
}
