// ResponseUser.swift
// Copyright © RoadMap. All rights reserved.

/// Друзья пользователя
struct ResponseUser: Codable {
    /// Друзья
    let friends: [UserItem]

    enum CodingKeys: String, CodingKey {
        case friends = "items"
    }
}
