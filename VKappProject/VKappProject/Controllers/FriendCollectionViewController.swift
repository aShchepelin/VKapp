// FriendCollectionViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Контроллер с фотографией друга
final class FriendCollectionViewController: UICollectionViewController {
    // MARK: - Public Properties

    var id = Constants.Items.emptyString

    // MARK: - Private Properties

    private let networkService = NetworkService()
    private let realmService = RealmService()

    private var photoItems: [PhotoItem] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Public Method

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Identifiers.segueFriendImagesIdentifier {
            guard let friendImages = segue.destination as? FriendImagesViewController else { return }
            if let indexPath = collectionView.indexPathsForSelectedItems?.first {
                friendImages.photoItems = photoItems
                friendImages.imageCurrentIndex = indexPath.row
            }
        }
    }

    // MARK: - Private Methods

    private func setupUI() {
        loadPhotos()
    }

    private func loadPhotos() {
        guard let photos = realmService.getData(PhotoItem.self) else { return }
        let userID = photos.map(\.ownerID)
        if userID.contains(where: { idUserFromRealm in
            idUserFromRealm == Int(id)
        }) {
            photoItems = photos.filter {
                $0.ownerID == Int(id)
            }
            collectionView.reloadData()
        } else {
            fetchFriendPhotos(id: id)
        }
    }

    private func fetchFriendPhotos(id: String) {
        networkService.fetchPhotos(for: id) { [weak self] friendPhoto in
            guard let self = self else { return }
            switch friendPhoto {
            case let .success(data):
                self.photoItems = data.response.photos
                self.realmService.saveData(self.photoItems)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }

    // MARK: UICollectionViewDataSource, UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoItems.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.Identifiers.friendCellIdentifier,
            for: indexPath
        ) as? FriendCollectionViewCell,
            let photo = photoItems[indexPath.row].sizes.last?.url else { return UICollectionViewCell() }
        cell.configureCell(photo)
        return cell
    }
}
