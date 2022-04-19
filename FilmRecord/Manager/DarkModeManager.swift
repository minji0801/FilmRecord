//
//  ThemeManager.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/18.
//  테마 관리자

import UIKit

enum Mode: Int {
    case light
    case dark
}

let key = "Appearance"

class DarkModeManager {
    /// Appearance 가져오기 (Default: light)
    static func getAppearance() -> Mode {
        guard let appearance = (
            UserDefaults.standard.value(forKey: key) as AnyObject
        ).integerValue else { return Mode(rawValue: 0)! }

        return Mode(rawValue: appearance)!
    }

    /// Appearance 저장하기
    static func setApperance(mode: Mode) {
        UserDefaults.standard.setValue(mode.rawValue, forKey: key)
        UserDefaults.standard.synchronize()
    }

    /// Appearance 적용하기
    static func applyAppearance(mode: Mode, viewController: UIViewController) {
        if mode == .light {
            viewController.overrideUserInterfaceStyle = .light
            viewController.navigationController?.navigationBar.barStyle = .default
            viewController.navigationController?.navigationBar.barTintColor = .white
            viewController.navigationController?.navigationBar.tintColor = .black
            viewController.navigationController?.navigationBar.titleTextAttributes = [
                .font: FontManager().extraLargeFont(),
                .foregroundColor: UIColor.black
            ]
        } else {
            viewController.overrideUserInterfaceStyle = .dark
            viewController.navigationController?.navigationBar.barStyle = .black
            viewController.navigationController?.navigationBar.barTintColor = .black
            viewController.navigationController?.navigationBar.tintColor = .white
            viewController.navigationController?.navigationBar.titleTextAttributes = [
                .font: FontManager().extraLargeFont(),
                .foregroundColor: UIColor.white
            ]
        }
    }
}
