// AvailableGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран доступных групп
final class AvailableGroupsTableViewController: UITableViewController {
    // MARK: - Private IBOutlets

    @IBOutlet private var groupsSearchBar: UISearchBar!

    // MARK: - Public Properties

    var closureForGroup: ((Group) -> Void)?

    // MARK: - Private Properties

    private var availableGroups = groups {
        didSet {
            tableView.reloadData()
        }
    }

    private lazy var searchResult: [Group] = []

    private var searchResultIsEmpty: Bool {
        guard let text = groupsSearchBar.text else { return false }
        return text.isEmpty
    }

    private var isFiltering: Bool {
        isSearching && !searchResultIsEmpty
    }

    private var isSearching = false

    // MARK: - Public Methods

    func addGroup(_ group: [Group], complition: @escaping ((Group) -> Void)) {
        availableGroups = availableGroups.filter { groups in
            !group.contains { myGroup in
                myGroup == groups
            }
        }
        closureForGroup = complition
    }

    // MARK: - Private Methods

    private func chooseGroup(_ indexPath: IndexPath) {
        let group = availableGroups[indexPath.row]
        closureForGroup?(group)
//        tableView.reloadData()
        navigationController?.popViewController(animated: true)
    }

    // MARK: - UITableViewDelegate, UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return searchResult.count
        } else {
            return availableGroups.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(
                withIdentifier: Constants.Identifiers
                    .availableGroupsCellIdentifier
            ) as? AvailableGroupTableViewCell
        else { return UITableViewCell() }
        let group = isFiltering ? searchResult[indexPath.row] : availableGroups[indexPath.row]
        cell.configureCell(group)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chooseGroup(indexPath)
    }
}

// MARK: - UISearchBarDelegate

extension AvailableGroupsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchResult = availableGroups.filter { $0.groupName.lowercased().contains(searchText.lowercased()) }
        isSearching = true
        tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}
