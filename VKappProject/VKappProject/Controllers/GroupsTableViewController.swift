// GroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран групп
final class GroupsTableViewController: UITableViewController {
    // MARK: - Private IBOutlets

    @IBOutlet private var groupsSearchBar: UISearchBar!

    // MARK: - Private Properties

    private var myGroups: [Group] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    private lazy var searchResult: [Group] = []

    private var isSearchResultEmpty: Bool {
        guard let text = groupsSearchBar.text else { return false }
        return text.isEmpty
    }

    private var isFiltering: Bool {
        isSearching && !isSearchResultEmpty
    }

    private var isSearching = false

    // MARK: - Public Methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.Identifiers.addGroupIdentifier,
              let availableTableVC = segue.destination as? AvailableGroupsTableViewController else { return }
        availableTableVC.addGroup(myGroups) { [weak self] group in
            self?.myGroups.append(group)
        }
    }

    // MARK: - UITableViewDelegate, UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return searchResult.count
        } else {
            return myGroups.count
        }
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            myGroups.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(
                withIdentifier: Constants.Identifiers
                    .groupsCellIdentifier
            ) as? MyGroupsTableViewCell else { return UITableViewCell() }
        let group = isFiltering ? searchResult[indexPath.row] : myGroups[indexPath.row]
        cell.configureCell(group)
        return cell
    }
}

// MARK: - UISearchBarDelegate

extension GroupsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchResult = myGroups.filter { $0.groupName.lowercased().contains(searchText.lowercased()) }
        isSearching = true
        tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}
