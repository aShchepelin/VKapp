// NewsItem.swift
// Copyright © RoadMap. All rights reserved.

/// Новость
final class NewsItem: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case sourceID = "source_id"
        case text
        case date
        case likes
        case views
    }

    /// Идентификатор публикации
    var id: Int
    /// Идентификатор группы
    var sourceID: Int
    /// Текст публикации
    var text: String
    /// Имя автора
    var authorName: String?
    /// Аватар автора
    var avatar: String?
    /// Картинка публикацим
    var postImage: String?
    /// Дата публикации
    var date: Int
    /// Лайки
    var likes: Likes?
    /// Просмотры
    var views: Views?
}
