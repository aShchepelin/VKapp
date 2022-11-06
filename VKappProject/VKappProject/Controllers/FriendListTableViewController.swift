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
        User(avatarImageName: Constants.UserImageNames.connorLloydImageName, name: Constants.UserNames.connorLloydName),
        User(avatarImageName: Constants.UserImageNames.emilieRivasImageName, name: Constants.UserNames.emilieRivasName),
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

    // MARK: - Public Method

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.Identifiers.friendCollectionViewController,
              let friendCollectionViewController = segue.destination as? FriendCollectionViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        friendCollectionViewController.friendAvatarName = users[indexPath.row].avatarImageName
    }

    // MARK: - UITableViewDelegate, UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(
                withIdentifier: Constants.Identifiers
                    .friendListCellIdentifier
            ) as? FriendListTableViewCell else { return UITableViewCell() }
        cell.configureCell(users[indexPath.row])
        return cell
    }
}
