// CustomInteractiveTransition.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерактивное закрытие экрана
class CustomInteractiveTransition: UIPercentDrivenInteractiveTransition {
    // MARK: - Public Properties

    var viewController: UIViewController? {
        didSet {
            let recognizer = UIScreenEdgePanGestureRecognizer(
                target: self,
                action: #selector(handleScreenEdgeGestureAction)
            )
            recognizer.edges = [.left]
            viewController?.view.addGestureRecognizer(recognizer)
        }
    }

    // MARK: - Public Property

    var isStarted: Bool = false

    // MARK: - Private Property

    private var isShouldFinish: Bool = false

    // MARK: - Private Methods

    @objc private func handleScreenEdgeGestureAction(
        _ recognizer:
        UIScreenEdgePanGestureRecognizer
    ) {
        switch recognizer.state {
        case .began:
            isStarted = true
            viewController?.navigationController?.popViewController(
                animated:
                true
            )
        case .changed:
            let translation = recognizer.translation(in: recognizer.view)
            let relativeTranslation = translation.y / (
                recognizer.view?.bounds.width
                    ?? CGFloat(Constants.AnimationParameters.relativeTranslationDefaultValue)
            )
            let progress = max(0, min(1, relativeTranslation))
            isShouldFinish = progress > Constants.AnimationParameters.progressPercent
            update(progress)
        case .ended:
            isStarted = false
            if isShouldFinish { finish()
            } else {
                cancel()
            }
        case .cancelled:
            isStarted = false
            cancel()
        default: return
        }
    }
}
