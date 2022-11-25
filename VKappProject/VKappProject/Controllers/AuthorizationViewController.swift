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

    private let vkAPIServuce = VKAPIService()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private Methods

    private func setupUI() {
        showAuthorizationWebView()
    }

    private func showAuthorizationWebView() {
        guard let request = vkAPIServuce.webViewURLComponents() else { return }
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
        Session.shared.token = token
        guard let userId = params[Constants.WebViewURLComponents.paramUserId] else { return }
        Session.shared.userID = userId
        decisionHandler(.cancel)
        let storyBoard = UIStoryboard(name: Constants.Identifiers.storyBoard, bundle: nil)
        let vc = storyBoard
            .instantiateViewController(
                withIdentifier: Constants.Identifiers
                    .loginViewControllerIdentifier
            )
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
    }
}
