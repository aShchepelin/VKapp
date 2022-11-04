// AvailableTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран доступных групп
final class AvailableTableViewController: UITableViewController {
    // MARK: - Public Properties

    var closureForGroup: ((Group) -> Void)?

    // MARK: - Private Properties

    private var availableGroup = groups {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Public Methods

    func addGroup(_ group: [Group], complition: @escaping ((Group) -> Void)) {
        availableGroup = availableGroup.filter { groups in
            !group.contains { myGroup in
                myGroup == groups
            }
        }
        closureForGroup = complition
    }

    // MARK: - UITableViewDelegate, UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        availableGroup.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(
                withIdentifier: Constants.Identifiers
                    .availableGroupsCellIdentifier
            ) as? AvailableGroupTableViewCell
        else { return UITableViewCell() }
        cell.groupImageView.image = UIImage(named: availableGroup[indexPath.row].groupAvatarImageName)
        cell.groupNameLabel.text = availableGroup[indexPath.row].groupName
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let group = availableGroup[indexPath.row]
        closureForGroup?(group)
        navigationController?.popViewController(animated: true)
    }
}
