// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import UIKit

/// Сервис по работе с API
final class NetworkService: NetworkServiceProtocol {
    // MARK: - Private Properties

    private let vkAPIService = VKAPIService()
    private let promiseServise = PromiseService()

    // MARK: - Public Methods

    func fetchNews(
        startTime: TimeInterval?,
        nextPage: String = Constants.Items.emptyString,
        completion: @escaping (Result<NewsResponse, Error>) -> Void
    ) {
        vkAPIService.sendNewsRequest(
            startTime: nil,
            nextPage: Constants.Items.emptyString,
            urlString: RequestType.news.urlString,
            completion: completion
        )
    }

    func fetchFriends(completion: @escaping (Result<User, Error>) -> Void) {
        vkAPIService.sendRequest(urlString: RequestType.friends.urlString, completion: completion)
    }

    func fetchGroups(completion: @escaping (Result<Group, Error>) -> Void) {
        vkAPIService.sendRequest(urlString: RequestType.groups.urlString, completion: completion)
    }

    func fetchOperationGroups() {
        vkAPIService.getGroups(urlString: RequestType.groups.urlString)
    }

    func fetchPhotos(for id: String, completion: @escaping (Result<Photo, Error>) -> Void) {
        vkAPIService.sendRequest(urlString: RequestType.photos(id: id).urlString, completion: completion)
    }

    func fetchSearchGroups(for searchText: String, completion: @escaping (Result<Group, Error>) -> Void) {
        vkAPIService.sendRequest(
            urlString: RequestType.searchGroups(searchQuery: searchText).urlString,
            completion: completion
        )
    }
}
