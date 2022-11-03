// FriendsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран списка друзей
final class FriendsTableViewController: UITableViewController {
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

    // MARK: - UITableViewDelegate, UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(
                withIdentifier: Constants.Identifiers
                    .friendListCellIdentifier
            ) as? FriendListTableViewCell else { return UITableViewCell() }
        cell.userAvatarImageView.image = UIImage(named: users[indexPath.row].avatarImageName)
        cell.userNameLabel.text = users[indexPath.row].name
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboardVC = UIStoryboard(name: ConstantsForSegue.storyboardName, bundle: nil)
        guard let nextScreen = storyboardVC
            .instantiateViewController(withIdentifier: ConstantsForSegue.friendCollectionViewControllerIdentifier)
            as? FriendCollectionViewController else { return }
        nextScreen.modalPresentationStyle = .fullScreen
        show(nextScreen, sender: nil)
        nextScreen.friendAvatarName = users[indexPath.row].avatarImageName
    }
}
