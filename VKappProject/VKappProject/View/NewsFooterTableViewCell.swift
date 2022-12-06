// NewsFooterTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерактивная панель публикации
final class NewsFooterTableViewCell: UITableViewCell, NewsCellConfigurable {
    // MARK: - Private IBOutlets

    @IBOutlet private var likeCountLabel: UILabel!
    @IBOutlet private var viewsCountLabel: UILabel!
    @IBOutlet private var likeButton: UIButton!

    // MARK: - Private Properties

    private var likeCounter = 0

    // MARK: - Public Methods

    func configureCell(_ news: NewsItem) {
        likeCountLabel.text = "\(news.likes.count)"
        viewsCountLabel.text = "\(news.views.count)"
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
}
