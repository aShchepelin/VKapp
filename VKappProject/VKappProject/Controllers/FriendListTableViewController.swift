// FriendListTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import UIKit

/// Список друзей
final class FriendListTableViewController: UITableViewController {
    // MARK: - Private Enum

    private enum ConstantsForSegue {
        static let storyboardName = "Main"
        static let friendCollectionViewControllerIdentifier = "friendCollectionViewController"
    }

    // MARK: - Private Properties

    private var users: [UserItem] = []
    private var sectionsMap: [Character: [UserItem]] = [:]
    private var sectionTitles: [Character] = []
    private let service = VKAPIService()

    // MARK: - LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    // MARK: - Public Method

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.Identifiers.friendCollectionViewControllerIdentifier,
              let friendCollectionViewController = segue.destination as? FriendCollectionViewController,
              let indexPath = tableView.indexPathForSelectedRow,
              let id = getOneUser(indexPath: indexPath)?.id else { return }
        friendCollectionViewController.id = String(id)
    }

    // MARK: - Private Method

    private func setupUI() {
        fetchFriendRequest()
    }

    private func setupFriends() {
        DispatchQueue.main.async { [self] in
            self.groupingUser()
            self.sectionTitles = Array(sectionsMap.keys).sorted()
            self.tableView.reloadData()
        }
    }

    private func getOneUser(indexPath: IndexPath) -> UserItem? {
        let firstChar = sectionsMap.keys.sorted()[indexPath.section]
        guard let users = sectionsMap[firstChar] else { return nil }
        let user = users[indexPath.row]
        return user
    }

    private func fetchFriendRequest() {
        AF
            .request(
                "\(Constants.URLComponents.baseURL)\(RequestType.friends.urlString)\(Constants.URLComponents.version)"
            )
            .responseData { [weak self] response in
                guard let data = response.value else { return }
                do {
                    let user = try JSONDecoder().decode(User.self, from: data)
                    self?.users = user.response.friends
                    self?.setupFriends()
                    print(user)
                } catch {
                    print(error)
                }
            }
    }

    private func groupingUser() {
        for userName in users {
            guard let firstLetter = userName.lastName.first else { return }
            if sectionsMap[firstLetter] != nil {
                sectionsMap[firstLetter]?.append(userName)
            } else {
                sectionsMap[firstLetter] = [userName]
            }
        }
    }

    // MARK: - UITableViewDelegate, UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = sectionsMap[sectionTitles[section]]?.count else { return 0 }
        return sections
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(
                withIdentifier: Constants.Identifiers
                    .friendListCellIdentifier
            ) as? FriendListTableViewCell,
            let groupedUser = sectionsMap[sectionTitles[indexPath.section]]?[indexPath.row]
        else { return UITableViewCell() }
        cell.configureCell(groupedUser)
        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        sectionsMap.count
    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        sectionTitles.map { String($0) }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        String(sectionTitles[section])
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        15
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        1
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as? UITableViewHeaderFooterView)?.contentView
            .backgroundColor = UIColor(named: Constants.Colors.placeholderColorName)?.withAlphaComponent(0.3)
        (view as? UITableViewHeaderFooterView)?.textLabel?.textColor = UIColor.white
    }
}
