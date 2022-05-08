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

        let password = UserDefaultsManager().getPassword()

        // 암호가 있을 때와 없을 때 구분
        if password.isEmpty {
            window?.rootViewController = UINavigationController(rootViewController: HomeViewController())
        } else {
            window?.rootViewController = UINavigationController(
                rootViewController: InputPasswordViewController(isEntry: true)
            )
        }
        window?.makeKeyAndVisible()
    }
}
