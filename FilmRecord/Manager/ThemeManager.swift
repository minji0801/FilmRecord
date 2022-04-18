//
//  ThemeManager.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/18.
//  테마 관리자

import UIKit

enum Theme: Int {

    case white, black, rolling, lemon, undergrowth, lily, bubbly, meeting

    /// 배경 색상
    var backgroundColor: UIColor {
        switch self {
        case .white:
            return UIColor().colorFromHexString("FFFFFF")
        case .black:
            return UIColor().colorFromHexString("000000")
        case .rolling:
            return UIColor().colorFromHexString("F4BBB8")
        case .lemon:
            return UIColor().colorFromHexString("F8D473")
        case .undergrowth:
            return UIColor().colorFromHexString("8FB789")
        case .lily:
            return UIColor().colorFromHexString("96D9E6")
        case .bubbly:
            return UIColor().colorFromHexString("9DABEC")
        case .meeting:
            return UIColor().colorFromHexString("D6CBF6")
        }
    }

    /// 보조 색상
    var secondaryColor: UIColor {
        switch self {
        case .white:
            return UIColor().colorFromHexString("F2F2F7")
        case .black:
            return UIColor().colorFromHexString("1C1C1E")
        case .rolling:
            return UIColor().colorFromHexString("FAE8E7")
        case .lemon:
            return UIColor().colorFromHexString("FEF6E2")
        case .undergrowth:
            return UIColor().colorFromHexString("D6F5D9")
        case .lily:
            return UIColor().colorFromHexString("D7F1F8")
        case .bubbly:
            return UIColor().colorFromHexString("DBE1F7")
        case .meeting:
            return UIColor().colorFromHexString("F4F2FD")
        }
    }
}

let selectedThemeKey = "SelectedTheme"

class ThemeManager {
    /// 현재 테마 가져오기
    static func currentTheme() -> Theme {
        if let storedTheme = (UserDefaults.standard.value(forKey: selectedThemeKey) as AnyObject).integerValue {
            return Theme(rawValue: storedTheme)!
        } else {
            // 저장된 테마가 없을 때 Appearance 저장된 값있는지 확인
            guard let appearance = UserDefaults.standard.string(forKey: "Appearance") else { return .white }

            if appearance == "Dark" {
                return .black
            } else {
                return .white
            }
        }
    }

    /// 테마 저장하기
    static func applyTheme(theme: Theme) {
        UserDefaults.standard.setValue(theme.rawValue, forKey: selectedThemeKey)
        UserDefaults.standard.synchronize()
    }
}
