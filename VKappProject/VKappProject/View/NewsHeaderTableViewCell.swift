// NewsHeaderTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Автор публикации
final class NewsHeaderTableViewCell: UITableViewCell {
    // MARK: - Private IBOutlets

    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var nickNameLabel: UILabel!
    @IBOutlet private var postDateLabel: UILabel!

    // MARK: - Private Properties

    private let dateFormatter = DateFormatter()

    // MARK: - Public Methods

    func configure(_ news: NewsItem, photoService: PhotoService) {
        guard let url = URL(string: news.avatar ?? "") else { return }
        postDateLabel.text = dateFormatter.convert(date: news.date)
        avatarImageView.load(url: url)
        nickNameLabel.text = news.authorName
    }
}

/// NewsCellConfigurable
extension NewsHeaderTableViewCell: NewsCellConfigurable {}
