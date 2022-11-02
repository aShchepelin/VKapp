// UIViewController+Exstension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение для алерта
extension UIViewController {
    // MARK: - Private Enum

    private enum Constants {
        static let alertActionTitleText = "OK"
    }

    // MARK: - Public Method

    func showLoginError(title: String, message: String) {
        let loginAlertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )

        let loginAlertAction = UIAlertAction(title: Constants.alertActionTitleText, style: .cancel)

        loginAlertController.addAction(loginAlertAction)

        present(loginAlertController, animated: true)
    }
}
