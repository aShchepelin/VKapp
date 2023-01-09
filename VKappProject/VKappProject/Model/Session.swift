// Session.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Инфо о сессии юзера
class Session {
    // MARK: - Public Properties

    static let shared = Session()

    // MARK: - Public Properties

    var userID = ""
    var token = ""

    // MARK: - Private Initializator

    private init() {}
}
