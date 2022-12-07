// NewsTextTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Текст публикации
final class NewsTextTableViewCell: UITableViewCell {
    // MARK: - Private IBOutlets

    @IBOutlet private var postTextView: UITextView!

    // MARK: - Public Methods

    func configure(_ news: NewsItem) {
        postTextView.text = news.text
    }
}

/// NewsCellConfigurable
extension NewsTextTableViewCell: NewsCellConfigurable {}
