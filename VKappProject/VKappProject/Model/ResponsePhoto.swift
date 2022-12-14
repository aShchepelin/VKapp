// ResponsePhoto.swift
// Copyright © RoadMap. All rights reserved.

/// Фотографии пользователей
struct ResponsePhoto: Codable {
    /// Фото
    let photos: [PhotoItem]
    enum CodingKeys: String, CodingKey {
        case photos = "items"
    }
}
