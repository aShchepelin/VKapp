// MyGroupsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с моими группами
final class MyGroupsTableViewCell: UITableViewCell {
    // MARK: - Private IBOutlets

    @IBOutlet private var groupNameLabel: UILabel!
    @IBOutlet private var groupAvatarImageView: UIImageView!

    // MARK: - Public Method

    func configureCell(_ model: GroupItem) {
        groupNameLabel.text = model.name
        guard let url = URL(string: model.photo) else { return }
        groupAvatarImageView.load(url: url)
    }
}
