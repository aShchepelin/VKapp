// NewsViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран новостей
final class NewsViewController: UIViewController {
    // MARK: Private Enum

    private enum NewsCellType: Int, CaseIterable {
        case header
        case content
        case footer
    }

    // MARK: - Private IBOutlet

    @IBOutlet private var newsTableView: UITableView!

    // MARK: - Private Properties

    private let vkAPIService = VKAPIService()
    private let networkService = NetworkService()
    private var news: [NewsItem] = []

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private Methods

    private func setupUI() {
        newsTableView.delegate = self
        newsTableView.dataSource = self
        fetchNews()
    }

    private func fetchNews() {
        networkService.fetchNews { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                self.filteringNews(newsResponse: data)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }

    private func filteringNews(newsResponse: NewsResponse) {
        newsResponse.news.forEach { news in
            if news.sourceID < 0 {
                guard let group = newsResponse.groups.filter({ group in
                    group.id == news.sourceID * -1
                }).first else { return }
                news.authorName = group.name
                news.avatar = group.photo
            } else {
                guard let user = newsResponse.users.filter({ user in
                    user.id == news.sourceID
                }).first else { return }
                news.authorName = "\(user.firstName) \(user.lastName)"
                news.avatar = user.photo
            }
        }
        DispatchQueue.main.async {
            self.news = newsResponse.news
            self.newsTableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NewsCellType.allCases.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        news.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let news = news[indexPath.section]
        let cellType = NewsCellType(rawValue: indexPath.row) ?? .content
        var cellIdentifier = ""

        switch cellType {
        case .header:
            cellIdentifier = Constants.Identifiers
                .newsHeaderCellIdentifier
        case .content:
            cellIdentifier = Constants.Identifiers.newsTextCellIdentifier
        case .footer:
            cellIdentifier = Constants.Identifiers
                .newsFooterCellIdentifier
        }
        guard let cell = tableView
            .dequeueReusableCell(
                withIdentifier: cellIdentifier
            ) as? NewsCell
        else { return UITableViewCell() }
        cell.configure(news)
        return cell
    }
}
