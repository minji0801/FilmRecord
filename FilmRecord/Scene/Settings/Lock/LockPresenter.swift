//
//  LockPresenter.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/27.
//  암호 잠금 Presenter

import Foundation
import UIKit
protocol LockProtocol: AnyObject {
    func setupAppearance()
    func setupNotification()
    func setupNavigationBar()
    func setupView(_ password: String)

    func applyFont()
    func popViewController()
    func showInputPasswordViewController()
    func switchOff()
}

final class LockPresenter: NSObject {
    private weak var viewController: LockProtocol?
    private let userDefaultsManager: UserDefaultsManagerProtocol

    var password: String = ""

    init(
        viewController: LockProtocol?,
        userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager()
    ) {
        self.viewController = viewController
        self.userDefaultsManager = userDefaultsManager
    }

    func viewDidLoad() {
        viewController?.setupAppearance()
        viewController?.setupNotification()
        viewController?.setupNavigationBar()
        viewController?.applyFont()
    }

    func viewWillAppear() {
        password = userDefaultsManager.getPassword()
        viewController?.setupView(password)
        print("암호:", password)
    }

    func didTappedLeftBarButton() {
        viewController?.popViewController()
    }

    func didTappedLockSwitch(isOn: Bool) {
        if isOn {
            viewController?.showInputPasswordViewController()
        } else {
            userDefaultsManager.setPassword("")
            viewWillAppear()
        }
    }

    func didTappedChangeButton() {
        viewController?.showInputPasswordViewController()
    }

    func cancelNotification() {
        viewController?.switchOff()
    }
}
