// LikePhotoControlView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Контрол для лайка
final class LikePhotoControl: UIControl {
    // MARK: - Private Enum

    private enum Constants {
        static let heartImageName = "heart"
        static let heartFillImageName = "heart.fill"
        static let buttonSelectedTag = "1"
        static let buttonNormalTag = "0"
    }

    // MARK: - Private IBOutlet

    @IBOutlet private var likeButton: UIButton!
    @IBOutlet private var likeCountLabel: UILabel!

    // MARK: - LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    // MARK: - Private Method

    private func setupUI() {
        likeButton.setImage(UIImage(systemName: Constants.heartImageName), for: .normal)
        likeCountLabel.text = Constants.buttonNormalTag
        likeButton.tintColor = .systemRed
    }

    // MARK: - Private IBAction

    @IBAction private func likeButtonAction(_ sender: Any) {
        if likeButton.tag == 0 {
            likeButton.setImage(UIImage(systemName: Constants.heartFillImageName), for: .normal)
            likeButton.tintColor = .systemRed
            likeButton.tag = 1
            likeCountLabel.text = Constants.buttonSelectedTag
        } else {
            likeButton.setImage(UIImage(systemName: Constants.heartImageName), for: .normal)
            likeCountLabel.text = Constants.buttonNormalTag
            likeButton.tag = 0
        }
    }
}
