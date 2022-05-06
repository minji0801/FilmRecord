//
//  InputPasswordPresenter.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/28.
//  비밀번화 입력 Presenter

import Foundation

protocol InputPasswordProtocol: AnyObject {
    func setupAppearance()
    func setupView()

    func applyFont()
    func dismiss()
    func updateDotsView(_ dotsRating: Double)
    func updateTopStackView(isConfirm: Bool)
}

final class InputPasswordPresenter: NSObject {
    private weak var viewController: InputPasswordProtocol?
    private let userDefaultsManager: UserDefaultsManagerProtocol

    private var firstPassword: String = ""  // 처음으로 입력한 암호
    private var secondPassword: String = "" // 두번째로 입력한 암호(확인하기 위해서)
    private var isFirst: Bool = true        // 처음입력한 암호인지

    init(
        viewController: InputPasswordProtocol?,
        userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager()
    ) {
        self.viewController = viewController
        self.userDefaultsManager = userDefaultsManager
    }

    func viewDidLoad() {
        viewController?.setupAppearance()
        viewController?.setupView()
        viewController?.applyFont()
    }

    func didTappedButton(_ tag: Int, _ dotsRating: Double) {
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

        if firstPassword.count == 4 && secondPassword.count == 0 {
            viewController?.updateTopStackView(isConfirm: true)
            isFirst = false
        } else if firstPassword.count == 4 && secondPassword.count == 4 {
            if firstPassword == secondPassword {
                // 맞으면 암호 저장하고 화면 닫기
                userDefaultsManager.setPassword(secondPassword)
                viewController?.dismiss()
            } else {
                // 틀리면 다시 시도하라고 화면 업데이트하기
                firstPassword = ""
                secondPassword = ""
                isFirst = true
                viewController?.updateTopStackView(isConfirm: false)
            }
        }
        print(firstPassword, secondPassword)
    }
}
