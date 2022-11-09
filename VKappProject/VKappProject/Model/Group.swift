// Group.swift
// Copyright © RoadMap. All rights reserved.

/// Группа
struct Group: Equatable {
    let groupAvatarImageName: String
    let groupName: String

    static let groups = [
        Group(
            groupAvatarImageName: Constants.GroupAvatarNames.americanRaidersImageName,
            groupName: Constants.GroupNames.americanRaidersName
        ),
        Group(
            groupAvatarImageName: Constants.GroupAvatarNames.awesomeStingersImageName,
            groupName: Constants.GroupNames.awesomeStingersName
        ),
        Group(
            groupAvatarImageName: Constants.GroupAvatarNames.butterflyBulletsImageName,
            groupName: Constants.GroupNames.butterflyBulletsName
        ),
        Group(
            groupAvatarImageName: Constants.GroupAvatarNames.newYorkMonkeysImageName,
            groupName: Constants.GroupNames.newYorkMonkeysName
        ),
        Group(
            groupAvatarImageName: Constants.GroupAvatarNames.redGeckosImageName,
            groupName: Constants.GroupNames.redGeckosName
        ),
        Group(
            groupAvatarImageName: Constants.GroupAvatarNames.teamHopeImageName,
            groupName: Constants.GroupNames.teamHopeName
        )
    ]
}
