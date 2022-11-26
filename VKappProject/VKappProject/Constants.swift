// Constants.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Константы
enum Constants {
    enum UserImageNames {
        static let ireneNormanImageName = "galina1"
        static let connorLloydImageName = "galina2"
        static let kaylynnGrossImageName = "galina3"
        static let kamronThomasImageName = "galina4"
        static let bryleeCollinsImageName = "galina5"
        static let martinSteinImageName = "galina6"
        static let kyleRosalesImageName = "galina7"
        static let emilieRivasImageName = "galina8"
    }

    enum UserNames {
        static let ireneNormanName = "Irene Norman"
        static let connorLloydName = "Connor Lloyd"
        static let kaylynnGrossName = "Kaylynn Gross"
        static let kamronThomasName = "Kamron Thomas"
        static let bryleeCollinsName = "Brylee Collins"
        static let martinSteinName = "Martin Stein"
        static let kyleRosalesName = "Kyle Rosales"
        static let emilieRivasName = "Emilie Rivas"
    }

    enum GroupAvatarNames {
        static let butterflyBulletsImageName = "group1"
        static let teamHopeImageName = "group2"
        static let americanRaidersImageName = "group3"
        static let newYorkMonkeysImageName = "group4"
        static let redGeckosImageName = "group5"
        static let awesomeStingersImageName = "group6"
    }

    enum GroupNames {
        static let butterflyBulletsName = "Butterfly Bullets"
        static let teamHopeName = "Team Hope"
        static let americanRaidersName = "American Raiders"
        static let newYorkMonkeysName = "New York Monkeys"
        static let redGeckosName = "Red Geckos"
        static let awesomeStingersName = "Awesome Stingers"
    }

    enum Identifiers {
        static let friendListCellIdentifier = "friendListCell"
        static let groupsCellIdentifier = "myGroupsCell"
        static let friendCellIdentifier = "friendCell"
        static let addGroupIdentifier = "addGroup"
        static let availableGroupsCellIdentifier = "availableGroupsCell"
        static let friendCollectionViewControllerIdentifier = "friendCollectionVC"
        static let newsViewControllerIdentifier = "news"
        static let segueFriendImagesIdentifier = "friendImages"
        static let mainStoryBoard = "Main"
        static let friendsTableViewControllerIdentifier = "friendsTableViewController"
        static let groupsTableViewControllerIdentifier = "groupsTableViewController"
        static let loginViewControllerIdentifier = "loginViewController"
    }

    enum Items {
        static let postDate = "01.12.2022"
        static let postText = """
        Переступив границу зрелых лет,
        Я в темный лес забрел и заблудился. И понял, что назад дороги нет...
        4 Где взять слова, которыми б решился Я этот лес угрюмый описать,
        Где ум померк и только ужас длился:
        7 Так даже смерть не может испугать...
        В глухом краю, зловещей тьмой одетом, Чего угодно мог я ожидать,
        10 Но только не спасения; нигде там
        Я не нашел, объятый смутным сном, Пути, что мне знаком по всем приметам.
        """
        static let heartImageName = "heart"
        static let heartFillImageName = "heart.fill"
        static let buttonSelectedTag = "1"
        static let buttonNormalTag = "0"
        static let positionForAnimation = "position"
        static let emptyString = ""
    }

    enum ColorNames {
        static let backgroundColorName = "BlueBackground"
        static let placeholderColorName = "placeholderTextColor"
    }

    enum AnimationParameters {
        static let duration = 0.5
        static let imageAlpha = 0.5
        static let relativeTranslationDefaultValue = 1
        static let scale = 0.8
        static let progressPercent = 0.33
        static let rotationAngle = -90
        static let translationXPoints = -200
    }

    enum URLComponents {
        static let baseURL = "https://api.vk.com/method/"
        static let version = "&v=5.131"
        static let friendsMethod = "friends.get?"
        static let userID = "/user_ids=\(Session.shared.userID)"
        static let accessToken = "&access_token=\(Session.shared.token)"
        static let friendsInfo = "&fields=photo_100"
        static let friendPhotoMethod = "photos.getAll?"
        static let testOwnerId = "407524"
        static let groupsMethod = "groups.get?"
        static let searchGroupMethod = "groups.search?"
        static let searchedQuery = "&q="
        static let extended = "&extended=1"
        static let ownerID = "&owner_id="
    }

    enum WebViewURLComponents {
        static let scheme = "https"
        static let host = "oauth.vk.com"
        static let path = "/authorize"
        static let clientIdName = "client_id"
        static let clientIdValue = "51484017"
        static let displayName = "display"
        static let displayValue = "mobile"
        static let redirectUriName = "redirect_uri"
        static let redirectUriValue = "https://oauth.vk.com/blank.html"
        static let scopeName = "scope"
        static let scopeValue = "262150"
        static let responseTypeName = "response_type"
        static let responseTypeValue = "token"
        static let versionName = "v"
        static let versionValue = "5.68"
        static let urlPath = "/blank.html"
        static let ampersandSeparator = "&"
        static let equalSeparator = "="
        static let paramAccessToken = "access_token"
        static let paramUserId = "user_id"
    }
}
