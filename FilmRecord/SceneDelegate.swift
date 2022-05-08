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

    // MARK: - UISceneSession Lifecycle

    /// InActive 될 때
    func sceneWillResignActive(_ scene: UIScene) {
        callBackgroundImage(true)
    }

    /// Active 될 때
    func sceneDidBecomeActive(_ scene: UIScene) {
        callBackgroundImage(false)
    }

    /// 화면 가림
    func callBackgroundImage(_ isShow: Bool) {
        let tag = -101
        let backgroundView = window?.rootViewController?.view.window?.viewWithTag(tag)

        if isShow {
            if backgroundView == nil {
                let view = UIView()
                view.tag = tag
                view.frame = UIScreen.main.bounds

                let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
                let blurEffectView = UIVisualEffectView(effect: blurEffect)
                blurEffectView.frame = view.bounds
                blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                view.addSubview(blurEffectView)

                window?.rootViewController?.view.window?.addSubview(view)
            }
        } else {
            if let backgroundView = backgroundView {
                backgroundView.removeFromSuperview()
            }
        }
    }
}
