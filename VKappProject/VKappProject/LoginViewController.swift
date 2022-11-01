// LoginViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Стартовый экран приложения
final class LoginViewController: UIViewController {
    // MARK: - Private Enum

    private enum Constants {
        static let loginText = "admin"
        static let passwordText = "123"
        static let alertTitleText = "Ошибка"
        static let alertMessageText = "Неправильный логин/пароль"
        static let identifier = "loginSegue"
        static let alertActionText = "OK"
    }

    // MARK: - Private IBOutlets

    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    // MARK: - Lifeсycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShownAction(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHideAction(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    // MARK: - Public Method

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == Constants.identifier {
            if checkLogin() {
                return true
            } else {
                showLoginError()
                return false
            }
        }
        return true
    }

    // MARK: - Private Methods

    @objc private func keyboardWillShownAction(notification: Notification) {
        guard let info = notification.userInfo as? NSDictionary else { return }
        guard let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue)?.cgRectValue.size
        else { return }
        let contectInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0)
        scrollView.contentInset = contectInset
        scrollView.scrollIndicatorInsets = contectInset
    }

    @objc private func keyboardWillHideAction(notification: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }

    @objc private func hideKeyboardAction() {
        scrollView.endEditing(true)
    }

    private func hideKeyboardGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardAction))
        scrollView.addGestureRecognizer(tapGesture)
    }

    private func setupUI() {
        loginTextField.setLeftPaddingPoints(10)
        passwordTextField.setLeftPaddingPoints(10)
    }

    private func checkLogin() -> Bool {
        guard let login = loginTextField.text else { return false }
        guard let password = passwordTextField.text else { return false }

        if login == Constants.loginText, password == Constants.passwordText {
            return true
        } else {
            return false
        }
    }

    private func showLoginError() {
        let alert = UIAlertController(
            title: Constants.alertTitleText,
            message: Constants.alertMessageText,
            preferredStyle: .alert
        )

        let action = UIAlertAction(title: Constants.alertActionText, style: .cancel)

        alert.addAction(action)

        present(alert, animated: true)
    }
}
