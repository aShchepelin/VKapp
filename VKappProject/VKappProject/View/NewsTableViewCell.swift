// NewsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка поста
final class NewsTableViewCell: UITableViewCell {
    // MARK: - Private IBOutlets

    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var nickNameLabel: UILabel!
    @IBOutlet private var postDateLabel: UILabel!
    @IBOutlet private var postTextLabel: UILabel!
    @IBOutlet private var postImageView: UIImageView!
    @IBOutlet private var likeCountLabel: UILabel!
    @IBOutlet private var viewsCountLabel: UILabel!
    @IBOutlet private var likeButton: UIButton!

    // MARK: - Private Properties

    private var likeCounter = 0

    // MARK: - LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    // MARK: - Public Methods

    func configureCell(_ news: News) {
        avatarImageView.image = UIImage(named: news.userAvatarName)
        nickNameLabel.text = news.userName
        postDateLabel.text = news.postDate
        postTextLabel.text = news.postMassageText
        postImageView.image = UIImage(named: news.postImageName)
        likeCountLabel.text = "\(news.likesCount)"
        viewsCountLabel.text = "\(news.viewsCount)"
        likeCounter = news.likesCount
    }

    // MARK: - Private IBAction

    @IBAction private func likeButtonAction(_ sender: Any) {
        likeDidTapAction()
        configureLikeButton()
    }

    // MARK: - Private Methods

    @objc private func likeDidTapAction() {
        likeButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            usingSpringWithDamping: 0.2,
            initialSpringVelocity: 0.5,
            options: .curveEaseInOut
        ) {
            self.likeButton.transform = .identity
        }
    }

    private func configureLikeButton() {
        guard likeButton.tag == 1 else {
            likeButton.setImage(UIImage(systemName: Constants.Items.heartFillImageName), for: .normal)
            likeButton.tintColor = .systemRed
            likeButton.tag = 1
            likeCounter += 1
            likeCountLabel.text = String(likeCounter)
            animationForLikeCount()
            return
        }
        likeButton.setImage(UIImage(systemName: Constants.Items.heartImageName), for: .normal)
        likeCounter -= 1
        likeCountLabel.text = String(likeCounter)
        likeButton.tag = 0
        animationForLikeCount()
    }

    private func animationForLikeCount() {
        let animation = CABasicAnimation(keyPath: Constants.Items.positionForAnimation)
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: likeCountLabel.center.x - 3, y: likeCountLabel.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: likeCountLabel.center.x + 3, y: likeCountLabel.center.y))

        likeCountLabel.layer.add(animation, forKey: Constants.Items.positionForAnimation)
    }

    private func setupUI() {
        postTextLabel.numberOfLines = 0
    }
}
