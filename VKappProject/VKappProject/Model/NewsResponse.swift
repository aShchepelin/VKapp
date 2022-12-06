// NewsResponse.swift
// Copyright © RoadMap. All rights reserved.

/// Новости
struct NewsResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case news = "items"
        case users = "profiles"
        case groups
    }

    /// Новости
    var news: [NewsItem]
    /// Пользователи
    var users: [UserItem]
    /// Группы
    var groups: [GroupItem]
}
