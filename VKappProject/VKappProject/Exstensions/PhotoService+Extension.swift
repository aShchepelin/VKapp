// PhotoService+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Хранение в контейнере DataReloadable классы таблиц и коллекций
extension PhotoService {
    class Collection: DataReloadable {
        func reloadRow(atIndexpath indexPath: IndexPath) {
            collectionView.reloadData()
        }

        let collectionView: UICollectionView

        init(collectionView: UICollectionView) {
            self.collectionView = collectionView
        }

        func reloadData() {
            collectionView.reloadData()
        }
    }

    class TableViewController: DataReloadable {
        // MARK: - Public properties

        let table: UITableViewController

        // MARK: - Initializers

        init(table: UITableViewController) {
            self.table = table
        }

        // MARK: - Public methods

        func reloadRow(atIndexpath indexPath: IndexPath) {
            table.tableView.reloadRows(at: [indexPath], with: .none)
        }
    }

    class Table: DataReloadable {
        // MARK: - Public properties

        let table: UITableView

        // MARK: - Initializers

        init(table: UITableView) {
            self.table = table
        }

        // MARK: - Public methods

        func reloadRow(atIndexpath indexPath: IndexPath) {
            table.reloadRows(at: [indexPath], with: .none)
        }
    }
}
