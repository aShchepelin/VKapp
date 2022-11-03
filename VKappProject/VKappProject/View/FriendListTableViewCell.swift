// FriendListTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с друзьями
final class FriendListTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var userAvatarImageView: UIImageView!
    @IBOutlet var shadowView: ShadowView!

    // MARK: - LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    // MARK: - Private Method

    private func setupUI() {
        shadowView.shadowConfigure()
    }
}
