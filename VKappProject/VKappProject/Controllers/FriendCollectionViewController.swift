// FriendCollectionViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Контроллер с фотографией друга
final class FriendCollectionViewController: UICollectionViewController {
    // MARK: - Public Property

    var friendAvatarName = ""

    // MARK: - Private Properies

    private let images = [
        UIImage(named: Constants.UserImageNames.ireneNormanImageName),
        UIImage(named: Constants.UserImageNames.emilieRivasImageName),
        UIImage(named: Constants.UserImageNames.connorLloydImageName)
    ]

    // MARK: - Public Methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Identifiers.segueFriendImagesIdentifier {
            guard let friendImages = segue.destination as? FriendImagesViewController else { return }
            if let indexPath = collectionView.indexPathsForSelectedItems?.first {
                friendImages.allImages = images
                friendImages.currentImageCounter = indexPath.row
            }
        }
    }

    // MARK: UICollectionViewDataSource, UICollectionViewDelegate

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
        cell.configureCell(friendAvatarName)
        return cell
    }
}
