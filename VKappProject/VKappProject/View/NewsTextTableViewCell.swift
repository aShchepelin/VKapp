// NewsTextTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Текст публикации
final class NewsTextTableViewCell: UITableViewCell, NewsCellConfigurable {
    // MARK: - Private IBOutlets

    @IBOutlet private var postTextView: UITextView!

    // MARK: - Public Methods

    func configureCell(_ news: NewsItem) {
        postTextView.text = news.text
    }
}
