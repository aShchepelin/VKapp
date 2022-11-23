// URLRequest.swift
// Copyright © RoadMap. All rights reserved.

/// Типы запросов
enum RequestType {
    case friends
    case groups
    case photos
    case searchGroups
    var urlString: String {
        switch self {
        case .friends:
            return "\(Constants.URLComponents.friendsMethod)\(Constants.URLComponents.accessToken)" +
                "\(Constants.URLComponents.friendsInfo)"
        case .groups:
            return "\(Constants.URLComponents.groupsMethod)\(Constants.URLComponents.testOwnerId)" +
                "\(Constants.URLComponents.accessToken)"
        case .photos:
            return "\(Constants.URLComponents.friendPhotoMethod)\(Constants.URLComponents.testOwnerId)" +
                "\(Constants.URLComponents.accessToken)"
        case .searchGroups:
            return "\(Constants.URLComponents.searchGroupMethod)\(Constants.URLComponents.accessToken)" +
                "\(Constants.URLComponents.searchedText)"
        }
    }
}
