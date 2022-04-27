//
//  SceneDelegate.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .systemBackground
        window?.tintColor = .label
        window?.rootViewController = UINavigationController(rootViewController: InputPasswordViewController())
        window?.makeKeyAndVisible()
    }
}
