// LoginViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран авторизации
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
    @IBOutlet private var loginTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!

    @IBOutlet private var firstDotView: UIView!
    @IBOutlet private var secondDotView: UIView!
    @IBOutlet private var thirdDotView: UIView!

    // MARK: - Lifeсycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notificationObserverForKeyboard()
        loadingAnimate()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeNotificationObserverForKeyboard()
    }

    // MARK: - Public Method

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard identifier == Constants.identifier,
              checkLogin()
        else {
            showLoginError(title: Constants.alertTitleText, message: Constants.alertMessageText)
            return false
        }
        return true
    }

    // MARK: - Private Methods

    @objc private func keyboardWillShownAction(notification: Notification) {
        guard let info = notification.userInfo as? NSDictionary else { return }
        guard let keyboardSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue)?.cgRectValue
            .size
        else { return }
        let contectInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0)
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

    private func removeNotificationObserverForKeyboard() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    private func notificationObserverForKeyboard() {
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

    private func checkLogin() -> Bool {
        guard let login = loginTextField.text,
              let password = passwordTextField.text,
              login == Constants.loginText,
              password == Constants.passwordText
        else {
            return false
        }
        return true
    }

    private func hideKeyboardGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardAction))
        scrollView.addGestureRecognizer(tapGesture)
    }

    private func setupUI() {
        loginTextField.setLeftPaddingPoints(10)
        passwordTextField.setLeftPaddingPoints(10)
    }

    private func loadingAnimate() {
        UIView.animate(withDuration: 0.7, delay: 0.4, options: [.autoreverse, .repeat]) {
            self.firstDotView.alpha = 0
        }

        UIView.animate(withDuration: 0.7, delay: 0.7, options: [.autoreverse, .repeat]) {
            self.secondDotView.alpha = 0
        }

        UIView.animate(withDuration: 0.7, delay: 1, options: [.autoreverse, .repeat]) {
            self.thirdDotView.alpha = 0
        }
    }
}
