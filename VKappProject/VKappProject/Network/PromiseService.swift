// PromiseService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import PromiseKit

/// Сервис по работе с запросами через PromiseKit
final class PromiseService {
    // MARK: - Public Method

    func sendFriendsRequest() -> Promise<User> {
        let promise = Promise<User> { resolver in
            AF.request(
                "\(Constants.URLComponents.baseURL)\(RequestType.friends.urlString)\(Constants.URLComponents.version)"
            )
            .responseData { response in
                guard let response = response.data else { return }
                do {
                    let object = try JSONDecoder().decode(User.self, from: response)
                    resolver.fulfill(object)
                } catch {
                    resolver.reject(error)
                }
            }
        }
        return promise
    }
}
