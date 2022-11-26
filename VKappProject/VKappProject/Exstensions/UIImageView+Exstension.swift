// UIImageView+Exstension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение для преобразования URL в UIImage
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
        }
    }
}
