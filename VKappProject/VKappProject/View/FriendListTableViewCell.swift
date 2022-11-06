// FriendListTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с друзьями
final class FriendListTableViewCell: UITableViewCell {
    // MARK: - Private IBOutlets

    @IBOutlet private var userNameLabel: UILabel!
    @IBOutlet private var userAvatarImageView: UIImageView!
    @IBOutlet private var shadowView: ShadowView!

    // MARK: - LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    // MARK: - Public Method

    func configureCell(_ model: User) {
        userNameLabel.text = model.name
        userAvatarImageView.image = UIImage(named: model.avatarImageName)
    }

    // MARK: - Private Method

    private func setupUI() {
        shadowView.shadowConfigure()
    }
}
