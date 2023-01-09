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

    func configureCell(_ model: UserItem) {
        userNameLabel.text = "\(model.firstName) \(model.lastName)"
        guard let url = URL(string: model.photo) else { return }
        userAvatarImageView.load(url: url)
    }

    // MARK: - Private Method

    private func setupUI() {
        shadowView.shadowConfigure()
    }
}
