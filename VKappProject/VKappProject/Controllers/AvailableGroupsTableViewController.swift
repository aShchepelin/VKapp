// AvailableGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import UIKit

/// Возможные группы
final class AvailableGroupsTableViewController: UITableViewController {
    // MARK: - Private IBOutlets

    @IBOutlet private var groupsSearchBar: UISearchBar!

    // MARK: - Private Properties

    private var searchResult: [GroupItem] = []

    private var searchResultIsEmpty: Bool {
        guard let text = groupsSearchBar.text else { return false }
        return text.isEmpty
    }

    private var isFiltering: Bool {
        isSearching && !searchResultIsEmpty
    }

    private var isSearching = false

    // MARK: - Private Methods

    private func fetchSearchedGroupsRequest(searchedText: String) {
        AF
            .request(
                "\(Constants.URLComponents.baseURL)" +
                    "\(RequestType.searchGroups(searchQuery: searchedText).urlString)\(Constants.URLComponents.version)"
            )
            .responseData { response in
                guard let data = response.value else { return }
                do {
                    let group = try JSONDecoder().decode(Group.self, from: data)
                    self.searchResult = group.response.groups
                } catch {
                    print(error)
                }
            }
    }

    // MARK: - UITableViewDelegate, UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResult.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(
                withIdentifier: Constants.Identifiers
                    .availableGroupsCellIdentifier
            ) as? AvailableGroupTableViewCell
        else { return UITableViewCell() }
        let group = searchResult[indexPath.row]
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
        searchBar.text = ""
        tableView.reloadData()
    }
}
