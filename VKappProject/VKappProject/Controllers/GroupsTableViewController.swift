// GroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран групп
final class GroupsTableViewController: UITableViewController {
    // MARK: - Private Properties

    private var myGroups = [groups.first].compactMap { $0 } {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - Public Methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.Identifiers.addGroupIdentifier,
              let availableTableVC = segue.destination as? AvailableTableViewController else { return }
        availableTableVC.addGroup(myGroups) { [weak self] group in
            self?.myGroups.append(group)
        }
    }

    // MARK: - UITableViewDelegate, UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myGroups.count
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            myGroups.remove(at: indexPath.row)
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(
                withIdentifier: Constants.Identifiers
                    .groupsCellIdentifier
            ) as? MyGroupsTableViewCell else { return UITableViewCell() }
        cell.groupAvatarImageView.image = UIImage(named: groups[indexPath.row].groupAvatarImageName)
        cell.groupNameLabel.text = groups[indexPath.row].groupName
        return cell
    }
}
