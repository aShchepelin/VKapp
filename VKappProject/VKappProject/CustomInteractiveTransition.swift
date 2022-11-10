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

    var hasStarted: Bool = false
    var shouldFinish: Bool = false

    // MARK: - Private Methods

    @objc private func handleScreenEdgeGestureAction(
        _ recognizer:
        UIScreenEdgePanGestureRecognizer
    ) {
        switch recognizer.state {
        case .began:
            hasStarted = true
            viewController?.navigationController?.popViewController(
                animated:
                true
            )
        case .changed:
            let translation = recognizer.translation(in: recognizer.view)
            let relativeTranslation = translation.y / (
                recognizer.view?.bounds.width
                    ?? 1
            )
            let progress = max(0, min(1, relativeTranslation))
            shouldFinish = progress > 0.33
            update(progress)
        case .ended:
            hasStarted = false
            if shouldFinish { finish()
            } else {
                cancel()
            }
        case .cancelled:
            hasStarted = false
            cancel()
        default: return
        }
    }
}
