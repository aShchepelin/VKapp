// AuthorizationViewController.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import UIKit
import WebKit

/// Экран авторизации
final class AuthorizationViewController: UIViewController {
    // MARK: - Private IBOutlet

    @IBOutlet private var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }

    // MARK: - Private Properties

    private let session = Session.shared

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private Methods

    private func setupUI() {
        webViewURLComponents()
    }

    private func webViewURLComponents() {
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
        guard let url = urlComponents.url else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

/// WKNavigationDelegate
extension AuthorizationViewController: WKNavigationDelegate {
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationResponse:
        WKNavigationResponse,
        decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void
    ) {
        guard let url = navigationResponse.response.url, url.path == Constants.WebViewURLComponents.urlPath,
              let fragment = url.fragment
        else {
            decisionHandler(.allow)
            return
        }
        let params = fragment
            .components(separatedBy: Constants.WebViewURLComponents.ampersandSeparator)
            .map { $0.components(separatedBy: Constants.WebViewURLComponents.equalSeparator) }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        guard let token = params[Constants.WebViewURLComponents.paramAccessToken] else { return }
        session.token = token
        guard let userId = params[Constants.WebViewURLComponents.paramUserId] else { return }
        session.userId = userId
        decisionHandler(.cancel)
        let storyBoard = UIStoryboard(name: Constants.Identifiers.storyBoard, bundle: nil)
        guard let vc = storyBoard
            .instantiateViewController(
                withIdentifier: Constants.Identifiers
                    .newsViewControllerIdentifier
            ) as? NewsViewController else { return }
        present(vc, animated: false, completion: nil)
    }
}
