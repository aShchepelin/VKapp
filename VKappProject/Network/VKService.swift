// VKService.swift
// Copyright © RoadMap. All rights reserved.

//  Created by Александр Андреевич Щепелин on 22.11.2022.

import Alamofire
import Foundation

/// Сетевой слой
final class VKService {
    // MARK: - Public Method

    func loadFriendList() {
        let url = Constants.URLComponents.baseURL + Constants.URLComponents.friendsMethod + Constants.URLComponents
            .userId + Session.shared.userId + Constants.URLComponents.accessToken + Session.shared.token + Constants
            .URLComponents.friendsInfo + Constants.URLComponents.version
        AF.request(url).responseJSON { response in
            print(response.value)
        }
    }

    func loadFriendPhoto() {
        let url = Constants.URLComponents.baseURL + Constants.URLComponents.friendPhotoMethod + Constants.URLComponents
            .testOwnerId + Constants.URLComponents.userId + Session.shared.userId + Constants.URLComponents
            .accessToken + Session.shared.token + Constants.URLComponents.version
        AF.request(url).responseJSON { response in
            print(response.value)
        }
    }

    func loadFriendGroups() {
        let url = Constants.URLComponents.baseURL + Constants.URLComponents.groupsMethod + Constants.URLComponents
            .testOwnerId + Constants.URLComponents.userId + Session.shared.userId + Constants.URLComponents
            .accessToken + Session.shared.token + Constants.URLComponents.version
        AF.request(url).responseJSON { response in
            print(response.value)
        }
    }

    func searchedGroups() {
        let url = Constants.URLComponents.baseURL + Constants.URLComponents.searchGroupMethod + Constants.URLComponents
            .userId + Session.shared.userId + Constants.URLComponents
            .accessToken + Session.shared.token + Constants.URLComponents
            .searchedText + Constants.URLComponents.version
        AF.request(url).responseJSON { response in
            print(response.value)
        }
    }
}
