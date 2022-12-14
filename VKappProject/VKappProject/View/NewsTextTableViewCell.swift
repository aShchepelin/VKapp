// NewsTextTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Текст публикации
final class NewsTextTableViewCell: UITableViewCell {
    // MARK: - Private IBOutlets

    @IBOutlet private var postTextLabel: UILabel!

    // MARK: - Public Methods

    func configure(_ news: NewsItem, photoService: PhotoService) {
        postTextLabel.text = news.text
        postTextLabel.numberOfLines = 5
    }
}

/// NewsCellConfigurable
extension NewsTextTableViewCell: NewsCellConfigurable {}
