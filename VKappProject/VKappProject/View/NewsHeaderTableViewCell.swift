// NewsHeaderTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Автор публикации
final class NewsHeaderTableViewCell: UITableViewCell, NewsCellConfigurable {
    // MARK: - Private IBOutlets

    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var nickNameLabel: UILabel!
    @IBOutlet private var postDateLabel: UILabel!

    // MARK: - Public Methods

    func configureCell(_ news: NewsItem) {
        guard let url = URL(string: news.avatar ?? "") else { return }
        let date = dateFormatter(date: news.date)
        avatarImageView.load(url: url)
        nickNameLabel.text = news.authorName
        postDateLabel.text = date
    }

    // MARK: - Private Methods

    private func dateFormatter(date: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(date))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
}
