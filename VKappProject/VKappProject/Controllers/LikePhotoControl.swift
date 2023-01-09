// LikePhotoControl.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Контрол для лайка
final class LikePhotoControl: UIControl {
    // MARK: - Private IBOutlet

    @IBOutlet private var likeButton: UIButton!
    @IBOutlet private var likeCountLabel: UILabel!

    // MARK: - LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    // MARK: - Private IBAction

    @IBAction private func likeButtonAction(_ sender: Any) {
        guard likeButton.tag == 1 else {
            likeButton.setImage(UIImage(systemName: Constants.Items.heartFillImageName), for: .normal)
            likeButton.tintColor = .systemRed
            likeButton.tag = 1
            likeCountLabel.text = Constants.Items.buttonSelectedTag
            return
        }
        likeButton.setImage(UIImage(systemName: Constants.Items.heartImageName), for: .normal)
        likeCountLabel.text = Constants.Items.buttonNormalTag
        likeButton.tag = 0
    }

    // MARK: - Private Method

    private func setupUI() {
        likeButton.setImage(UIImage(systemName: Constants.Items.heartImageName), for: .normal)
        likeCountLabel.text = Constants.Items.buttonNormalTag
        likeButton.tintColor = .systemRed
    }
}
