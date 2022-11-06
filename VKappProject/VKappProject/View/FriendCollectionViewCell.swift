// FriendCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с другом
final class FriendCollectionViewCell: UICollectionViewCell {
    // MARK: Private IBOutlet

    @IBOutlet private var friendImageView: UIImageView!

    // MARK: - Public Method

    func configureCell(_ imageName: String) {
        friendImageView.image = UIImage(named: imageName)
    }
}
