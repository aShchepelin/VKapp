// NetworkServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
/// Протокол для сетевого слоя
protocol NetworkServiceProtocol {
    func fetchFriends(completion: @escaping (Result<User, Error>) -> Void)
    func fetchGroups(completion: @escaping (Result<Group, Error>) -> Void)
    func fetchOperationGroups()
    func fetchPhotos(for id: String, completion: @escaping (Result<Photo, Error>) -> Void)
    func fetchSearchGroups(for searchText: String, completion: @escaping (Result<Group, Error>) -> Void)
    func fetchNews(
        startTime: TimeInterval?,
        nextPage: String,
        completion: @escaping (Result<NewsResponse, Error>) -> Void
    )
}
