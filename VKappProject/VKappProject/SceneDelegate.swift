//
//  SceneDelegate.swift
//  VKappProject
//

import UIKit

/// SceneDelegate
final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(
        _ scene: UIScene,
        willConnectTo _: UISceneSession,
        options _: UIScene.ConnectionOptions
    ) {
        guard let applicationScene = (scene as? UIWindowScene) else { return }
        window?.windowScene = applicationScene
        window?.makeKeyAndVisible()

        let startViewController = ViewController()
        let navigationController = UINavigationController(rootViewController: startViewController)
        window?.rootViewController = navigationController
    }
}
