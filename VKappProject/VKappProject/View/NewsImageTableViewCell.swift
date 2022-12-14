// NewsImageTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Картинка публикации
final class NewsImageTableViewCell: UITableViewCell {
    // MARK: - Private IBOutlets

    @IBOutlet private var postImageView: UIImageView!

    // MARK: - Public Methods

    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
    }

    func configure(_ news: NewsItem, photoService: PhotoService) {
        postImageView.image = photoService.photo(byUrl: news.attachments?.first?.photo?.sizes.last?.url ?? "")
    }
}

/// NewsCellConfigurable
extension NewsImageTableViewCell: NewsCellConfigurable {}
