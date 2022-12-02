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
