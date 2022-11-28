// GroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран групп
final class GroupsTableViewController: UITableViewController {
    // MARK: - Private IBOutlets

    @IBOutlet private var groupsSearchBar: UISearchBar!

    // MARK: - Private Properties

    private var groupItems: [GroupItem] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    private var networkService: NetworkServiceProtocol = NetworkService()

    private lazy var searchedGroupItems: [GroupItem] = []

    private var isSearchResultEmpty: Bool {
        guard let text = groupsSearchBar.text else { return false }
        return text.isEmpty
    }

    private var isFiltering: Bool {
        isSearching && !isSearchResultEmpty
    }

    private var isSearching = false

    // MARK: - LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    // MARK: - Private Methods

    private func setupUI() {
        fetchGroupRequest()
    }

    private func fetchGroupRequest() {
        networkService.fetchGroups { [weak self] group in
            guard let self = self else { return }
            switch group {
            case let .success(data):
                self.groupItems = data.response.groups
            case let .failure(error):
                print(error)
            }
        }
    }

    // MARK: - UITableViewDelegate, UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return searchedGroupItems.count
        } else {
            return groupItems.count
        }
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            groupItems.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(
                withIdentifier: Constants.Identifiers
                    .groupsCellIdentifier
            ) as? MyGroupsTableViewCell else { return UITableViewCell() }
        let group = isFiltering ? searchedGroupItems[indexPath.row] : groupItems[indexPath.row]
        cell.configureCell(group)
        return cell
    }
}

// MARK: - UISearchBarDelegate

extension GroupsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedGroupItems = groupItems.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        isSearching = true
        tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}
