// News.swift
// Copyright © RoadMap. All rights reserved.

/// Новости
struct News {
    let userName: String
    let postDate: String
    let userAvatarName: String
    let postMassageText: String
    let postImageName: String
    let likesCount: Int
    let viewsCount: Int

    static let posts = [
        News(
            userName: Constants.UserNames.connorLloydName,
            postDate: Constants.Items.postDate,
            userAvatarName: Constants.UserImageNames.connorLloydImageName,
            postMassageText: Constants.Items.postText,
            postImageName: Constants.GroupAvatarNames.redGeckosImageName,
            likesCount: 12,
            viewsCount: 150
        ),
        News(
            userName: Constants.UserNames.connorLloydName,
            postDate: Constants.Items.postDate,
            userAvatarName: Constants.UserImageNames.connorLloydImageName,
            postMassageText: Constants.Items.postText,
            postImageName: Constants.GroupAvatarNames.butterflyBulletsImageName,
            likesCount: 12,
            viewsCount: 150
        )
    ]
}
