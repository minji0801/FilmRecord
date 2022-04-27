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
    func setupNavigationBar()
    func setupView(_ password: String)

    func applyFont()
    func popViewController()
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
        password = userDefaultsManager.getPassword()
        viewController?.setupAppearance()
        viewController?.setupNavigationBar()
        viewController?.setupView(password)
        viewController?.applyFont()
    }

    func didTappedLeftBarButton() {
        viewController?.popViewController()
    }

    func didTappedLockSwitch(isOn: Bool) {
        if isOn {
            // 암호 입력 화면 보여주기
        } else {
            // UserDefaults에 저장한 암호 지우기
        }
    }
}
