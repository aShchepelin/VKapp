// Session.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// ВК синглтон
class Session {
    // MARK: - Public Properties

    static let shared = Session()

    // MARK: - Private Initializator

    private init() {}

    // MARK: - Public Properties

    var userId = ""
    var token = ""
}
