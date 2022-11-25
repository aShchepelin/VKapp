// Group.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Группа
struct Group: Decodable {
    let response: ResponseGroup
}

/// Группы пользователя
struct ResponseGroup: Codable {
    let groups: [GroupItem]

    enum CodingKeys: String, CodingKey {
        case groups = "items"
    }
}

/// Информация о группах
final class GroupItem: Object, Codable {
    @objc dynamic var id: Int
    @objc dynamic var name: String
    @objc dynamic var photo: String
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo = "photo_100"
    }
}
