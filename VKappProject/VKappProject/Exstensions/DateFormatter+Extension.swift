// DateFormatter+Extension.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Расширение для форматирование даты
extension DateFormatter {
    func convert(date: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(date))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.Items.dateFormat
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
}
