// FriendCollectionViewController.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import UIKit

/// Контроллер с фотографией друга
final class FriendCollectionViewController: UICollectionViewController {
    // MARK: - Public Properties

    var id = Constants.Items.emptyString

    // MARK: - Private Properties

    private var images: [PhotoItem] = [] {
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
                friendImages.allImages = images
                friendImages.currentImageCounter = indexPath.row
            }
        }
    }

    // MARK: - Private Methods

    private func setupUI() {
        fetchFriendPhotosRequest(id: id)
    }

    private func fetchFriendPhotosRequest(id: String) {
        AF
            .request(
                "\(Constants.URLComponents.baseURL)" +
                    "\(RequestType.photos(id: Int(id) ?? 0).urlString)\(Constants.URLComponents.version)"
            )
            .responseData { response in
                guard let data = response.value else { return }
                do {
                    let photo = try JSONDecoder().decode(Photo.self, from: data)
                    self.images = photo.response.photos
                } catch {
                    print(error)
                }
            }
    }

    // MARK: UICollectionViewDataSource, UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.Identifiers.friendCellIdentifier,
            for: indexPath
        ) as? FriendCollectionViewCell,
            let photo = images[indexPath.row].sizes.last?.url else { return UICollectionViewCell() }
        cell.configureCell(photo)
        return cell
    }
}
