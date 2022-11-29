// ResponseGroup.swift
// Copyright © RoadMap. All rights reserved.

/// Группы пользователя
struct ResponseGroup: Codable {
    let groups: [GroupItem]
    enum CodingKeys: String, CodingKey {
        case groups = "items"
    }
}
