// NewsResponse.swift
// Copyright © RoadMap. All rights reserved.

/// Новости
struct NewsResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case news = "items"
        case users = "profiles"
        case groups
        case nextPage = "next_from"
    }

    /// Новости
    let news: [NewsItem]
    /// Пользователи
    let users: [UserItem]
    /// Группы
    let groups: [GroupItem]
    /// Следующая страница
    let nextPage: String?
}
