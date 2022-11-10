// CustomPopTransitionAnimator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Аниматор Pop
final class CustomPopTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    // MARK: - Private Properties

    private let duration: TimeInterval = 0.35

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
        destination.view.transform = CGAffineTransform(translationX: -width, y: 0)
            .concatenating(CGAffineTransform(scaleX: 0.8, y: 0.8))
        destination.view.center = CGPoint(x: width / 2, y: source.view.center.y)
        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: .calculationModePaced
        ) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                let translation = CGAffineTransform(translationX: width, y: 0)
                let rotation = CGAffineTransform(rotationAngle: .pi / -2)
                source.view.center = CGPoint(x: width + height / 2, y: width / 2)
                source.view.transform = translation.concatenating(rotation)
            }

            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                destination.view.transform = .identity
            }
        } completion: { finished in
            if finished, !transitionContext.transitionWasCancelled {
                destination.view.transform = .identity
                transitionContext.completeTransition(true)
            } else {
                transitionContext.completeTransition(false)
            }
        }
    }
}
