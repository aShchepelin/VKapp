// AvailableTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран доступных групп
final class AvailableTableViewController: UITableViewController {
    // MARK: - Private Properties

    private var availableGroups = groups {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - Public Properties

    var closureForGroup: ((Group) -> Void)?

    // MARK: - Public Methods

    func addGroup(_ group: [Group], complition: @escaping ((Group) -> Void)) {
        availableGroups = availableGroups.filter { groups in
            !group.contains { myGroup in
                myGroup == groups
            }
        }
        closureForGroup = complition
    }

    private func chooseGroup() {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let group = availableGroups[indexPath.row]
        closureForGroup?(group)
        navigationController?.popViewController(animated: true)
    }

    // MARK: - UITableViewDelegate, UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        availableGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(
                withIdentifier: Constants.Identifiers
                    .availableGroupsCellIdentifier
            ) as? AvailableGroupTableViewCell
        else { return UITableViewCell() }
        cell.configureCell(availableGroups[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chooseGroup()
    }
}
