// AvailableGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Доступные группы
final class AvailableGroupsTableViewController: UITableViewController {
    // MARK: - Private IBOutlets

    @IBOutlet private var groupsSearchBar: UISearchBar!

    // MARK: - Private Properties

    private var networkService: NetworkServiceProtocol = NetworkService()

    private var searchGroupItems: [GroupItem] = []

    private var isSearchResultEmpty: Bool {
        guard let text = groupsSearchBar.text else { return false }
        return text.isEmpty
    }

    private var isFiltering: Bool {
        isSearching && !isSearchResultEmpty
    }

    private var isSearching = false

    // MARK: - Private Methods

    private func fetchSearchedGroupsRequest(searchedText: String) {
        networkService.fetchSearchGroups(for: searchedText) { [weak self] group in
            guard let self = self else { return }
            switch group {
            case let .success(data):
                self.searchGroupItems = data.response.groups
                self.tableView.reloadData()
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchGroupItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(
                withIdentifier: Constants.Identifiers
                    .availableGroupsCellIdentifier
            ) as? AvailableGroupTableViewCell
        else { return UITableViewCell() }
        let group = searchGroupItems[indexPath.row]
        cell.configureCell(group)
        return cell
    }
}

// MARK: - UISearchBarDelegate

extension AvailableGroupsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        fetchSearchedGroupsRequest(searchedText: searchText)
        tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = Constants.Items.emptyString
        tableView.reloadData()
    }
}
