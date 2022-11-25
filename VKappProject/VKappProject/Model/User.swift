// User.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Пользователь
struct User: Decodable {
    let response: ResponseUser
}

/// Друзья пользователя
struct ResponseUser: Codable {
    let friends: [UserItem]

    enum CodingKeys: String, CodingKey {
        case friends = "items"
    }
}

/// Информация о друзьях
final class UserItem: Object, Codable {
    @objc dynamic var id: Int
    @objc dynamic var firstName: String
    @objc dynamic var lastName: String
    @objc dynamic var photo: String
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo_100"
    }
}
