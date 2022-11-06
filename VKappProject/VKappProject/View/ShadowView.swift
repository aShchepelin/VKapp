// ShadowView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Вью с тенью
final class ShadowView: UIView {
    // MARK: - Public Properties

    override class var layerClass: AnyClass {
        CAShapeLayer.self
    }

    // MARK: - Private Properties

    @IBInspectable private var shadowRadius: CGFloat = 8 {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable private var shadowOpacity: Float = 0.5 {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable private var shadowColor: UIColor = .black {
        didSet {
            setNeedsDisplay()
        }
    }

    // MARK: - Public Methods

    func shadowConfigure() {
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
    }
}
