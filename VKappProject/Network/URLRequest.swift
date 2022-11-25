// URLRequest.swift
// Copyright © RoadMap. All rights reserved.

/// Типы запросов
enum RequestType {
    case friends
    case groups
    case photos(id: Int)
    case searchGroups(searchQuery: String)
    var urlString: String {
        switch self {
        case .friends:
            return "\(Constants.URLComponents.friendsMethod)\(Constants.URLComponents.accessToken)" +
                "\(Constants.URLComponents.friendsInfo)"
        case .groups:
            return "\(Constants.URLComponents.groupsMethod)\(Constants.URLComponents.testOwnerId)" +
                "\(Constants.URLComponents.accessToken)\(Constants.URLComponents.extended)"
        case let .photos(id):
            return "\(Constants.URLComponents.friendPhotoMethod)" +
                "\(Constants.URLComponents.extended)\(Constants.URLComponents.ownerID)\(id)" +
                "\(Constants.URLComponents.accessToken)"
        case let .searchGroups(searchQuery):
            return "\(Constants.URLComponents.searchGroupMethod)" +
                "\(Constants.URLComponents.accessToken)" +
                "\(Constants.URLComponents.searchedQuery)\(searchQuery)"
        }
    }
}
