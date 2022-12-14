// NetworkServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
/// Протокол для сетевого слоя
protocol NetworkServiceProtocol {
    func fetchFriends(complition: @escaping (Result<User, Error>) -> Void)
    func fetchGroups(complition: @escaping (Result<Group, Error>) -> Void)
    func fetchOperationGroups()
    func fetchPhotos(for id: String, complition: @escaping (Result<Photo, Error>) -> Void)
    func fetchSearchGroups(for searchText: String, complition: @escaping (Result<Group, Error>) -> Void)
    func fetchNews(
        startTime: TimeInterval?,
        nextPage: String,
        complition: @escaping (Result<NewsResponse, Error>) -> Void
    )
}
