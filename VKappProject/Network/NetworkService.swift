// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire

final class NetworkService: NetworkServiceProtocol {
    // MARK: - Private Properties

    private let vkAPIService = VKAPIService()

    // MARK: - Public Methods

    func fetchFriends(complition: @escaping (Result<User, Error>) -> Void) {
        vkAPIService.sendRequest(urlString: RequestType.friends.urlString, complition: complition)
    }

    func fetchGroups(complition: @escaping (Result<Group, Error>) -> Void) {
        vkAPIService.sendRequest(urlString: RequestType.groups.urlString, complition: complition)
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
