// FriendCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с другом
final class FriendCollectionViewCell: UICollectionViewCell {
    // MARK: Private IBOutlets

    @IBOutlet private var friendImageView: UIImageView!

    // MARK: - Public Methods

    func configureCell(_ imageName: String) {
        friendImageView.image = UIImage(named: imageName)
    }
}
