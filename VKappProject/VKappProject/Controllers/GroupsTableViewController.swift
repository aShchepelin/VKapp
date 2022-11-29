// GroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift
import UIKit

/// Экран групп
final class GroupsTableViewController: UITableViewController {
    // MARK: - Private IBOutlets

    @IBOutlet private var groupsSearchBar: UISearchBar!

    // MARK: - Private Properties

    private var groupItems: Results<GroupItem>? {
        didSet {
            tableView.reloadData()
        }
    }

    private let networkService: NetworkServiceProtocol = NetworkService()
    private let realmService = RealmService()
    private var notificationToken: NotificationToken?
    private var searchedGroupItems: Results<GroupItem>?
    private var isSearchResultEmpty: Bool {
        guard let text = groupsSearchBar.text else { return false }
        return text.isEmpty
    }

    // MARK: - LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    // MARK: - Private Methods

    private func setupUI() {
        loadGroupToRealm()
    }

    private func loadGroupToRealm() {
        do {
            let realm = try Realm()
            let groups = realm.objects(GroupItem.self)
            addNotificationToken(result: groups)
            if !groups.isEmpty {
                groupItems = groups
            } else {
                fetchGroupRequest()
            }
        } catch {
            print(error)
        }
    }

    private func fetchGroupRequest() {
        networkService.fetchGroups { [weak self] group in
            guard let self = self else { return }
            switch group {
            case let .success(data):
                self.realmService.saveDataToRealm(data.response.groups)
            case let .failure(error):
                print(error)
            }
        }
    }

    private func addNotificationToken(result: Results<GroupItem>) {
        notificationToken = result.observe { change in
            switch change {
            case .initial:
                break
            case .update:
                self.groupItems = result
            case let .error(error):
                print(error)
            }
        }
    }

    // MARK: - UITableViewDelegate, UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groupItems?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(
                withIdentifier: Constants.Identifiers
                    .groupsCellIdentifier
            ) as? MyGroupsTableViewCell,
            let groupItems = groupItems?[indexPath.row] else { return UITableViewCell() }
        let group = groupItems
        cell.configureCell(group)
        return cell
    }
}
