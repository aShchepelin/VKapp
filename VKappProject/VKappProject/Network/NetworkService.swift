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
        complition: @escaping (Result<NewsResponse, Error>) -> Void
    ) {
        vkAPIService.sendNewsRequest(
            startTime: nil,
            nextPage: Constants.Items.emptyString,
            urlString: RequestType.news.urlString,
            complition: complition
        )
    }

    func fetchFriends(complition: @escaping (Result<User, Error>) -> Void) {
        vkAPIService.sendRequest(urlString: RequestType.friends.urlString, complition: complition)
    }

    func fetchGroups(complition: @escaping (Result<Group, Error>) -> Void) {
        vkAPIService.sendRequest(urlString: RequestType.groups.urlString, complition: complition)
    }

    func fetchOperationGroups() {
        vkAPIService.getGroups(urlString: RequestType.groups.urlString)
    }

    func fetchPhotos(for id: String, complition: @escaping (Result<Photo, Error>) -> Void) {
        vkAPIService.sendRequest(urlString: RequestType.photos(id: id).urlString, complition: complition)
    }

    func fetchSearchGroups(for searchText: String, complition: @escaping (Result<Group, Error>) -> Void) {
        vkAPIService.sendRequest(
            urlString: RequestType.searchGroups(searchQuery: searchText).urlString,
            complition: complition
        )
    }
}
