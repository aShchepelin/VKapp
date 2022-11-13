// CustomPopTransitionAnimator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Каcтомный переход назад, взамен стандартного  pop
final class CustomPopTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    // MARK: - Public Methods

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        Constants.AnimationParameters.duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from),
              let destination = transitionContext.viewController(forKey: .to) else { return }
        let width = source.view.bounds.width
        let height = source.view.bounds.height
        transitionContext.containerView.addSubview(destination.view)
        destination.view.frame = source.view.frame
        destination.view.transform = CGAffineTransform(translationX: -width, y: 0)
            .concatenating(CGAffineTransform(
                scaleX: Constants.AnimationParameters.scale,
                y: Constants.AnimationParameters.scale
            ))
        destination.view.center = CGPoint(x: width / 2, y: source.view.center.y)
        UIView.animateKeyframes(
            withDuration: Constants.AnimationParameters.duration,
            delay: 0,
            options: .calculationModePaced
        ) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: Constants.AnimationParameters.duration) {
                let translation = CGAffineTransform(translationX: width, y: 0)
                let rotation = CGAffineTransform(rotationAngle: Constants.AnimationParameters.rotationAngle)
                source.view.center = CGPoint(x: width + height / 2, y: width / 2)
                source.view.transform = translation.concatenating(rotation)
            }

            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: Constants.AnimationParameters.duration) {
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
