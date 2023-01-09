// UITextField+Exstension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение для отступа
extension UITextField {
    func setLeftPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: frame.size.height))
        leftView = paddingView
        leftViewMode = .always
    }
}
