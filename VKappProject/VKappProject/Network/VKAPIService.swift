// VKAPIService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire

/// Сервис по работе с запросами
final class VKAPIService {
    // MARK: - Public Method

    func sendRequest<T: Decodable>(urlString: String, complition: @escaping (Result<T, Error>) -> Void) {
        AF.request(
            "\(Constants.URLComponents.baseURL)\(urlString)" +
                "\(Constants.URLComponents.version)"
        )
        .responseJSON { response in
            guard let response = response.data else { return }
            do {
                let object = try JSONDecoder().decode(T.self, from: response)
                complition(.success(object))
            } catch {
                complition(.failure(error))
            }
        }
    }

    func sendNewsRequest(
        startTime: TimeInterval? = nil,
        nextPage: String = Constants.Items.emptyString,
        urlString: String,
        complition: @escaping (Result<NewsResponse, Error>) -> Void
    ) {
        AF.request(
            "\(Constants.URLComponents.baseURL)\(urlString)" +
                "\(Constants.URLComponents.version)\(Constants.URLComponents.startTime)" +
                "\(startTime ?? 0)\(Constants.URLComponents.startTime)\(nextPage)"
        )
        .responseJSON { response in
            guard let response = response.data else { return }
            do {
                let object = try JSONDecoder().decode(News.self, from: response)
                complition(.success(object.response))
            } catch {
                complition(.failure(error))
            }
        }
    }

    func getGroupRequest(urlString: String) -> DataRequest {
        let request = AF.request(
            "\(Constants.URLComponents.baseURL)\(urlString)\(Constants.URLComponents.version)"
        )

        return request
    }

    func getGroups(urlString: String) {
        let operationQueue = OperationQueue()
        let request = getGroupRequest(urlString: urlString)
        let getDataOperation = GetDataOperation(request: request)
        operationQueue.addOperation(getDataOperation)
        let parseData = ParseData()
        parseData.addDependency(getDataOperation)
        operationQueue.addOperation(parseData)
        let groupsTableViewController = GroupsTableViewController()
        let saveRealm = SaveRealmOperation()
        saveRealm.addDependency(parseData)
        operationQueue.addOperation(saveRealm)
    }

    func webViewURLComponents() -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.WebViewURLComponents.scheme
        urlComponents.host = Constants.WebViewURLComponents.host
        urlComponents.path = Constants.WebViewURLComponents.path
        urlComponents.queryItems = [
            URLQueryItem(
                name: Constants.WebViewURLComponents.clientIdName,
                value: Constants.WebViewURLComponents.clientIdValue
            ),
            URLQueryItem(
                name: Constants.WebViewURLComponents.displayName,
                value: Constants.WebViewURLComponents.displayValue
            ),
            URLQueryItem(
                name: Constants.WebViewURLComponents.redirectUriName,
                value: Constants.WebViewURLComponents.redirectUriValue
            ),
            URLQueryItem(
                name: Constants.WebViewURLComponents.scopeName,
                value: Constants.WebViewURLComponents.scopeValue
            ),
            URLQueryItem(
                name: Constants.WebViewURLComponents.responseTypeName,
                value: Constants.WebViewURLComponents.responseTypeValue
            ),
            URLQueryItem(
                name: Constants.WebViewURLComponents.versionName,
                value: Constants.WebViewURLComponents.versionValue
            )
        ]
        guard let components = urlComponents.url else { return nil }
        let request = URLRequest(url: components)
        return request
    }
}
