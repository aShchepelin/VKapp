// CustomNavigationController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Кастомный NavigationController
final class CustomNavigationController: UINavigationController {
    // MARK: - Private Properties

    private let interactiveTransition = CustomInteractiveTransition()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    // MARK: - Private Methods

    private func setupUI() {
        delegate = self
    }
}

// MARK: - UINavigationControllerDelegate

extension CustomNavigationController: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            interactiveTransition.viewController = toVC
            return CustomPushTransitionAnimator()
        } else {
            interactiveTransition.viewController = toVC
            return CustomPopTransitionAnimator()
        }
    }

    func navigationController(
        _ navigationController: UINavigationController,
        interactionControllerFor animationController:
        UIViewControllerAnimatedTransitioning
    )
        -> UIViewControllerInteractiveTransitioning? { interactiveTransition.isStarted ? interactiveTransition : nil }
}
