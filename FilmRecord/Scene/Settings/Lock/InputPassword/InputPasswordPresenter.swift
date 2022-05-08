//
//  InputPasswordPresenter.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/28.
//  비밀번화 입력 Presenter

import AVFoundation
import Foundation

protocol InputPasswordProtocol: AnyObject {
    func setupAppearance()
    func setupView(_ isEntry: Bool)

    func applyFont()
    func dismiss()
    func updateDotsView(_ dotsRating: Double)
    func updateTopStackView(_ tag: Int)
    func showHomeViewController()
}

final class InputPasswordPresenter: NSObject {
    private weak var viewController: InputPasswordProtocol?
    private let userDefaultsManager: UserDefaultsManagerProtocol

    private var isEntry: Bool

    private var firstPassword: String = ""  // 처음으로 입력한 암호
    private var secondPassword: String = "" // 두번째로 입력한 암호(확인하기 위해서)
    private var isFirst: Bool = true        // 처음입력한 암호인지

    init(
        viewController: InputPasswordProtocol?,
        userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager(),
        isEntry: Bool
    ) {
        self.viewController = viewController
        self.userDefaultsManager = userDefaultsManager
        self.isEntry = isEntry
    }

    func viewDidLoad() {
        viewController?.setupAppearance()
        viewController?.setupView(isEntry)
        viewController?.applyFont()
    }

    func didTappedButton(_ tag: Int, _ dotsRating: Double) {
        if isEntry { isFirst = true }

        switch tag {
        case -1:    // 취소
            viewController?.dismiss()
        case -2:    // Del
            if isFirst {
                firstPassword = firstPassword.isEmpty ? "" : "\(firstPassword.dropLast())"
            } else {
                secondPassword = secondPassword.isEmpty ? "" : "\(secondPassword.dropLast())"
            }
            viewController?.updateDotsView(dotsRating > 0.0 ? dotsRating - 1.0 : 0.0)
        default:    // 숫자
            if isFirst {
                firstPassword = firstPassword.count < 4 ? "\(firstPassword)\(String(tag))" : firstPassword
            } else {
                secondPassword = secondPassword.count < 4 ? "\(secondPassword)\(String(tag))" : secondPassword
            }
            viewController?.updateDotsView(dotsRating < 4.0 ? dotsRating + 1.0 : 4.0)
        }

        if isEntry && firstPassword.count == 4 {
            checkEntryPassword()
        } else if !isEntry {
            checkSettingPassword()
        }
    }

    /// 앱 진입시 입력한 암호가 맞는지 확인
    func checkEntryPassword() {
        let password = userDefaultsManager.getPassword()

        if password == firstPassword {
            // 첫번째로 입력한 암호가 맞음 -> 홈화면 보여주기
            viewController?.showHomeViewController()
        } else {
            // 불일치하면 다시 입력해 달라고 하기.(진동울리기)
            firstPassword = ""
            viewController?.updateTopStackView(2)
            AudioServicesPlaySystemSound(4095)
        }
    }

    /// 암호 설정시 입력한 암호가 맞는지 확인
    func checkSettingPassword() {
        // 첫번째 암호 입력했을 때 -> 두번째 암호 입력하라고 알려주기
        if firstPassword.count == 4 && secondPassword.count == 0 {
            viewController?.updateTopStackView(0)
            isFirst = false
        } else if firstPassword.count == 4 && secondPassword.count == 4 {
            // 처음입력한 암호와 두번째로 입력한 암호가 일치할 때
            if firstPassword == secondPassword {
                // 맞으면 암호 저장하고 화면 닫기
                userDefaultsManager.setPassword(secondPassword)
                viewController?.dismiss()
            } else {
                // 틀리면 다시 시도하라고 화면 업데이트하기
                firstPassword = ""
                secondPassword = ""
                isFirst = true
                viewController?.updateTopStackView(1)
                AudioServicesPlaySystemSound(4095)
            }
        }
    }
}
