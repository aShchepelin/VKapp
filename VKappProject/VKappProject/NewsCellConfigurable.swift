// NewsCellConfigurable.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Псевдоним для конфигурирования ячеек
typealias NewsCell = UITableViewCell & NewsCellConfigurable

/// Протокол для конфигурации ячеек
protocol NewsCellConfigurable {
    func configure(_ news: NewsItem)
}
