// Size.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Параметры фото
final class Size: Object, Codable {
    /// Адрес фотографии
    @Persisted var url: String
}
