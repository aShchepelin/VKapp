// CustomPushTransitionAnimator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Аниматор Pop
final class CustomPushTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    // MARK: - Private Properties

    private let duration: TimeInterval = 0.5

    // MARK: - Public Methods

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from),
              let destination = transitionContext.viewController(forKey: .to) else { return }
        let width = source.view.bounds.width
        let height = source.view.bounds.height
        transitionContext.containerView.addSubview(destination.view)
        destination.view.frame = source.view.frame
        let rotation = CGAffineTransform(rotationAngle: .pi / -2)
        destination.view.transform = rotation
        destination.view.center = CGPoint(x: width + height / 2, y: width / 2)
        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: .calculationModePaced
        ) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                let translation = CGAffineTransform(translationX: -200, y: 0)
                let rotation = CGAffineTransform(scaleX: 0.8, y: 0.8)
                source.view.transform = translation.concatenating(rotation)
            }

            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                destination.view.transform = .identity
                destination.view.center = source.view.center
            }
        } completion: { finished in
            if finished, !transitionContext.transitionWasCancelled {
                source.view.transform = .identity
                transitionContext.completeTransition(true)
            } else {
                transitionContext.completeTransition(false)
            }
        }
    }
}
