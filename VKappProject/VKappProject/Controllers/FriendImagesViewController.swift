// FriendImagesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран фотографий с перелистываниями
final class FriendImagesViewController: UIViewController {
    // MARK: - Private IBOutlets

    @IBOutlet private var photoImageView: UIImageView!

    // MARK: - Public Properties

    var photoItems: [PhotoItem] = []
    var imageCurrentIndex = 0

    // MARK: - Private Properties

    private var interactiveAnimator: UIViewPropertyAnimator!

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private Methods

    @objc private func panGestureRecognizerAction(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            interactiveAnimator?.startAnimation()
            interactiveAnimator = UIViewPropertyAnimator(
                duration: Constants.AnimationParameters.duration,
                curve: .easeInOut,
                animations: {
                    self.photoImageView.alpha = Constants.AnimationParameters.imageAlpha
                    self.photoImageView.transform = .init(scaleX: 1.5, y: 1.5)
                }
            )
            interactiveAnimator.pauseAnimation()
        case .changed:
            let translation = recognizer.translation(in: view)
            interactiveAnimator.fractionComplete = abs(translation.x / 100)
            photoImageView.transform = CGAffineTransform(translationX: translation.x, y: 0)
        case .ended:
            interactiveAnimator.stopAnimation(true)
            if recognizer.translation(in: view).x < 0 {
                if imageCurrentIndex < photoItems
                    .count - 1 { imageCurrentIndex += 1 }
            } else {
                if imageCurrentIndex != 0 {
                    imageCurrentIndex -= 1
                }
            }
            interactiveAnimator.addAnimations {
                self.photoImageView.transform = .identity
                self.photoImageView.alpha = 1
            }
            interactiveAnimator?.startAnimation()
        default: break
        }
        guard let url = URL(string: photoItems[imageCurrentIndex].sizes.last?.url ?? "") else { return }
        photoImageView.load(url: url)
    }

    private func setupUI() {
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panRecognizer)
        guard let url = URL(string: photoItems[imageCurrentIndex].sizes.last?.url ?? "") else { return }
        photoImageView.load(url: url)
    }
}
