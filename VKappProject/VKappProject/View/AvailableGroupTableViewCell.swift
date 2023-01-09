// AvailableGroupTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка доступных групп
final class AvailableGroupTableViewCell: UITableViewCell {
    // MARK: - Private IBOutlets

    @IBOutlet private var groupImageView: UIImageView!
    @IBOutlet private var groupNameLabel: UILabel!

    // MARK: - Public Method

    func configureCell(_ model: GroupItem) {
        groupNameLabel.text = model.name
        guard let url = URL(string: model.photo) else { return }
        groupImageView.load(url: url)
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(avatarDidTapAction))
        groupImageView.addGestureRecognizer(gestureRecognizer)
        groupImageView.isUserInteractionEnabled = true
    }

    // MARK: - Private Methods

    @objc private func avatarDidTapAction() {
        groupImageView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        UIView.animate(
            withDuration: 3,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 5,
            options: .curveEaseInOut
        ) {
            self.groupImageView.transform = .identity
        }
    }
}
