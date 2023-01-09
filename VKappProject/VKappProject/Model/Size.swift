// Size.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Параметры фото
final class Size: Object, Codable {
    /// Адрес фотографии
    @Persisted var url: String
    /// Ширина
    var width: Int
    /// Высота
    var height: Int
    /// Соотношение сторон
    var aspectRatio: CGFloat { CGFloat(height) / CGFloat(width) }
}
