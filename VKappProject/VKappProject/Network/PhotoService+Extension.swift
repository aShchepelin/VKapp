// PhotoService+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Хранение в контейнере DataReloadable классы таблиц и коллекций
extension PhotoService {
    class Collection: DataReloadable {
        let collectionView: UICollectionView

        init(collectionView: UICollectionView) {
            self.collectionView = collectionView
        }

        func reloadRow(atIndexpath indexPath: IndexPath) {
            collectionView.reloadItems(at: [indexPath])
        }
    }

    class CollectionViewController: DataReloadable {
        let collectionViewController: UICollectionViewController

        init(collectionViewController: UICollectionViewController) {
            self.collectionViewController = collectionViewController
        }

        func reloadRow(atIndexpath indexPath: IndexPath) {
            collectionViewController.collectionView.reloadItems(at: [indexPath])
        }
    }
}
