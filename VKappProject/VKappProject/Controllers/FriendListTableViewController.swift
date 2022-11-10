// FriendListTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран списка друзей
final class FriendListTableViewController: UITableViewController {
    // MARK: - Private Enum

    private enum ConstantsForSegue {
        static let storyboardName = "Main"
        static let friendCollectionViewControllerIdentifier = "friendCollectionViewController"
    }

    // MARK: - Private Properties

    private let users: [User] = [
        User(
            avatarImageName: Constants.UserImageNames.bryleeCollinsImageName,
            name: Constants.UserNames.bryleeCollinsName
        ),
        User(avatarImageName: Constants.UserImageNames.emilieRivasImageName, name: Constants.UserNames.emilieRivasName),
        User(avatarImageName: Constants.UserImageNames.connorLloydImageName, name: Constants.UserNames.connorLloydName),
        User(avatarImageName: Constants.UserImageNames.ireneNormanImageName, name: Constants.UserNames.ireneNormanName),
        User(
            avatarImageName: Constants.UserImageNames.kamronThomasImageName,
            name: Constants.UserNames.kamronThomasName
        ),
        User(
            avatarImageName: Constants.UserImageNames.kaylynnGrossImageName,
            name: Constants.UserNames.kaylynnGrossName
        ),
        User(avatarImageName: Constants.UserImageNames.kyleRosalesImageName, name: Constants.UserNames.kyleRosalesName),
        User(avatarImageName: Constants.UserImageNames.martinSteinImageName, name: Constants.UserNames.martinSteinName)
    ]

    private var sections: [Character: [User]] = [:]
    private var sectionTitles: [Character] = []

    // MARK: - LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
        groupingUser()
    }

    // MARK: - Public Method

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.Identifiers.friendCollectionViewControllerIdentifier,
              let friendCollectionViewController = segue.destination as? FriendCollectionViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let keys = sections.keys.sorted()
        let key = keys[indexPath.section]
        guard let friendAvatar = sections[key]?[indexPath.row] else { return }
        friendCollectionViewController.friendAvatarName = friendAvatar.avatarImageName
    }

    // MARK: - Private Method

    private func groupingUser() {
        for userName in users {
            guard let firstLetter = userName.name.first else { return }
            if sections[firstLetter] != nil {
                sections[firstLetter]?.append(userName)
            } else {
                sections[firstLetter] = [userName]
            }
        }
        sectionTitles = Array(sections.keys).sorted()
    }

    // MARK: - UITableViewDelegate, UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = sections[sectionTitles[section]]?.count else { return 0 }
        return sections
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(
                withIdentifier: Constants.Identifiers
                    .friendListCellIdentifier
            ) as? FriendListTableViewCell,
            let groupedUser = sections[sectionTitles[indexPath.section]]?[indexPath.row]
        else { return UITableViewCell() }
        cell.configureCell(groupedUser)
        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
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
