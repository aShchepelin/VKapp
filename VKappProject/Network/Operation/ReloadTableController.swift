// ReloadTableController.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Перетаскивание данных
final class ReloadTableController: Operation {
    var controller: GroupsTableViewController
    init(controller: GroupsTableViewController) {
        self.controller = controller
    }

    override func main() {
        guard let parseData = dependencies.first as? ParseData else { return }
        controller.groups = parseData.outputData
//        controller.tableView.reloadData()
    }
}
