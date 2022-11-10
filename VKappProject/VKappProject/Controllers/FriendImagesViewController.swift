// FriendImagesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран фотографий с перелистываниями
final class FriendImagesViewController: UIViewController {
    // MARK: - Private IBOutlets

    @IBOutlet private var photoImageView: UIImageView!

    // MARK: - Public Properties

    var allImages: [UIImage?] = []
    var currentImageCounter = 0
    
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
                duration: 0.5,
                curve: .easeInOut,
                animations: {
                    self.photoImageView.alpha = 0.5
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
                if currentImageCounter < allImages
                    .count - 1 { currentImageCounter += 1 }
            } else {
                if currentImageCounter != 0 {
                    currentImageCounter -= 1
                }
            }
            interactiveAnimator.addAnimations {
                self.photoImageView.transform = .identity
                self.photoImageView.alpha = 1
            }
            interactiveAnimator?.startAnimation()

        default: break
        }
        photoImageView.image = allImages[currentImageCounter]
    }

    private func setupUI() {
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panRecognizer)
        photoImageView.image = allImages[currentImageCounter]
    }
}
