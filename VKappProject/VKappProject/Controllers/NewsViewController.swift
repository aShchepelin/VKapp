// NewsViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран новостей
final class NewsViewController: UIViewController {
    // MARK: Private Enum

    private enum NewsCellType: Int, CaseIterable {
        case header
        case text
        case image
        case footer
    }

    // MARK: - Private IBOutlet

    @IBOutlet private var newsTableView: UITableView!

    // MARK: - Private Properties

    private let vkAPIService = VKAPIService()
    private let networkService = NetworkService()
    private var news: [NewsItem] = []
    private let refreshControll = UIRefreshControl()
    private var isLoading: Bool = false
    private var currentDate = 0
    private var nextPage = Constants.Items.emptyString

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private Methods

    private func setupUI() {
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.prefetchDataSource = self
        newsTableView.addSubview(refreshControll)
        fetchNews()
        setupRefreshControll()
    }

    private func setupRefreshControll() {
        refreshControll.addTarget(
            self,
            action: #selector(refreshDataAction),
            for: .valueChanged
        )
    }

    private func fetchNews() {
        var mostFreshDate: TimeInterval?
        if let firstItem = news.first {
            mostFreshDate = Double(firstItem.date) + 1
        }

        networkService.fetchNews(startTime: mostFreshDate) { [weak self] result in

            guard let self = self else { return }
            self.refreshControll.endRefreshing()
            switch result {
            case let .success(data):
                self.news = self.filteringNews(newsResponse: data) + self.news
                self.newsTableView.reloadData()
                self.nextPage = data.nextPage ?? Constants.Items.emptyString
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }

    private func filteringNews(newsResponse: NewsResponse) -> [NewsItem] {
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
        return newsResponse.news
    }

    @objc func refreshDataAction() {
        fetchNews()
        newsTableView.reloadData()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching

extension NewsViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NewsCellType.allCases.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        news.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let news = news[indexPath.section]
        guard let cellType = NewsCellType(rawValue: indexPath.row) else { return UITableViewCell() }
        var cellIdentifier = Constants.Items.emptyString
        switch cellType {
        case .header:
            cellIdentifier = Constants.Identifiers
                .newsHeaderCellIdentifier
        case .image:
            cellIdentifier = Constants.Identifiers.newsImageCellIdentifier
        case .footer:
            cellIdentifier = Constants.Identifiers
                .newsFooterCellIdentifier
        case .text:
            cellIdentifier = Constants.Identifiers.newsTextCellIdentifier
        }
        guard let cell = tableView
            .dequeueReusableCell(
                withIdentifier: cellIdentifier
            ) as? NewsCell
        else { return UITableViewCell() }
        cell.configure(news)
        return cell
    }

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let sections = indexPaths.map(\.section)
        guard let maxSection = sections.max(),
              maxSection > news.count - 3,
              isLoading == false
        else { return }
        isLoading = true
        networkService.fetchNews(startTime: nil, nextPage: nextPage) { [weak self] news in
            guard let self = self else { return }
            switch news {
            case let .success(data):
                let indexSet = (self.news.count ..< self.news.count + data.news.count).map { $0 }
                self.currentDate = data.news.first?.date ?? 0
                self.news.append(contentsOf: data.news)
                self.isLoading = false
                self.newsTableView.insertSections(IndexSet(indexSet), with: .automatic)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 2:
            let tableWidth = tableView.bounds.width
            guard let aspectRatio = news[indexPath.section].attachments?.last?.photo?.sizes.first?.aspectRatio
            else { return CGFloat() }
            let cellHeight = tableWidth * aspectRatio
            return cellHeight
        default:
            return UITableView.automaticDimension
        }
    }
}
