// MyGroupsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с моими группами
final class MyGroupsTableViewCell: UITableViewCell {
    // MARK: - Private IBOutlets

    @IBOutlet private var groupNameLabel: UILabel!
    @IBOutlet private var groupAvatarImageView: UIImageView!

    // MARK: - Public Method

    func configureCell(_ groupItem: GroupItem) {
        groupNameLabel.text = groupItem.name
        guard let url = URL(string: groupItem.photo) else { return }
        groupAvatarImageView.load(url: url)
    }
}
