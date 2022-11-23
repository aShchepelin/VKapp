// NewsViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран новостей
final class NewsViewController: UIViewController {
    // MARK: - Private IBOutlet

    @IBOutlet private var newsTableView: UITableView!

    // MARK: - Private Properties

    private let vkAPIService = VKAPIService()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private Methods

    private func setupUI() {
        newsTableView.delegate = self
        newsTableView.dataSource = self
        sendRequest()
    }

    private func sendRequest() {
        vkAPIService.sendRequest(urlString: RequestType.friends.urlString)
        vkAPIService.sendRequest(urlString: RequestType.photos.urlString)
        vkAPIService.sendRequest(urlString: RequestType.groups.urlString)
        vkAPIService.sendRequest(urlString: RequestType.searchGroups.urlString)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        News.posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(
                withIdentifier: Constants.Identifiers
                    .newsViewControllerIdentifier
            ) as? NewsTableViewCell
        else { return UITableViewCell() }
        cell.configureCell(News.posts[indexPath.row])
        return cell
    }
}
