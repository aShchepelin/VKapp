// GroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import UIKit

/// Экран групп
final class GroupsTableViewController: UITableViewController {
    // MARK: - Private IBOutlets

    @IBOutlet private var groupsSearchBar: UISearchBar!

    // MARK: - Private Properties

    private var myGroups: [GroupItem] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    private lazy var searchResult: [GroupItem] = []

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

    private func reloadData() {
        DispatchQueue.main.async { [self] in
            self.tableView.reloadData()
        }
    }

    private func fetchGroupRequest() {
        AF
            .request(
                "\(Constants.URLComponents.baseURL)\(RequestType.groups.urlString)\(Constants.URLComponents.version)"
            )
            .responseData { response in
                guard let data = response.value else { return }
                do {
                    let group = try JSONDecoder().decode(Group.self, from: data)
                    self.myGroups = group.response.groups
                    self.reloadData()
                    print(group)
                } catch {
                    print(error)
                }
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
        searchResult = myGroups.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        isSearching = true
        tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}
