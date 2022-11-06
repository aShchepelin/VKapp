// AvailableGroupTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка доступных групп
final class AvailableGroupTableViewCell: UITableViewCell {
    // MARK: - Private IBOutlets

    @IBOutlet private var groupImageView: UIImageView!
    @IBOutlet private var groupNameLabel: UILabel!

    // MARK: - Public Method

    func configureCell(_ model: Group) {
        groupNameLabel.text = model.groupName
        groupImageView.image = UIImage(named: model.groupAvatarImageName)
    }
}
