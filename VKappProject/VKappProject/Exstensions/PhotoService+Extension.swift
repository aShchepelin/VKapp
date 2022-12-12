// PhotoService+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Хранение в контейнере DataReloadable классы таблиц и коллекций
extension PhotoService {
    class Collection {
        let collectionView: UICollectionView

        init(collectionView: UICollectionView) {
            self.collectionView = collectionView
        }

        func reloadData() {
            collectionView.reloadData()
        }
    }
}
