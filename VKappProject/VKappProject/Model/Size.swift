// Size.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Параметры фото
final class Size: Object, Codable {
    @Persisted var url: String
}
