// FriendCollectionViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с фотографией друга
final class FriendCollectionViewController: UICollectionViewController {
    // MARK: - Public Property

    var friendAvatarName = ""

    // MARK: UICollectionViewDataSource, UICollectionViewDelegate

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.Identifiers.friendCellIdentifier,
            for: indexPath
        ) as? FriendCollectionViewCell else { return UICollectionViewCell() }
        cell.friendImageView.image = UIImage(named: friendAvatarName)
        return cell
    }
}
