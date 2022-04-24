//
//  FontManager.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/30.
//

import Foundation
import UIKit

enum FontSize: CGFloat {
    case small = 12
    case medium = 14
    case large = 16
    case extraLarge = 18
}

enum Font: Int {
    case kyobo      // 교보손글씨2019
    case leeseoyun  // 이서윤체

    static let allValues = [kyobo, leeseoyun]

    /// 아이폰 작은 글씨(size: 12)
    var smallFont: UIFont {
        switch self {
        case .kyobo:
            return UIFont(name: "KyoboHandwriting2019", size: FontSize.small.rawValue)!
        case .leeseoyun:
            return UIFont(name: "LeeSeoyun", size: FontSize.small.rawValue)!
        }
    }

    /// 아이폰 중간 글씨(size: 14)
    var mediumFont: UIFont {
        switch self {
        case .kyobo:
            return UIFont(name: "KyoboHandwriting2019", size: FontSize.medium.rawValue)!
        case .leeseoyun:
            return UIFont(name: "LeeSeoyun", size: FontSize.medium.rawValue)!
        }
    }

    /// 아이폰 큰 글씨(size: 16)
    var largeFont: UIFont {
        switch self {
        case .kyobo:
            return UIFont(name: "KyoboHandwriting2019", size: FontSize.large.rawValue)!
        case .leeseoyun:
            return UIFont(name: "LeeSeoyun", size: FontSize.large.rawValue)!
        }
    }

    /// 아이폰 더 큰 글씨(size: 18)
    var extraLargeFont: UIFont {
        switch self {
        case .kyobo:
            return UIFont(name: "KyoboHandwriting2019", size: FontSize.extraLarge.rawValue)!
        case .leeseoyun:
            return UIFont(name: "LeeSeoyun", size: FontSize.extraLarge.rawValue)!
        }
    }
}

let fontKey = "Font"

class FontManager {
    /// 저장된 폰트 가져오기
    static func getFont() -> Font {
        if let font = (UserDefaults.standard.value(forKey: fontKey) as AnyObject).integerValue {
            return Font(rawValue: font)!
        } else {
            // 저장된 폰트가 없으면 기본 폰트로
            return .leeseoyun
        }
    }
    /// 폰트 저장하기
    static func setFont(font: Font) {
        UserDefaults.standard.setValue(font.rawValue, forKey: fontKey)
        UserDefaults.standard.synchronize()
    }

    static let familyName = "LeeSeoyun"

    /// FontSize: 12
    static func smallFont() -> UIFont {
        return UIFont(name: familyName, size: FontSize.small.rawValue)!
    }

    /// FontSize: 14
    static func mediumFont() -> UIFont {
        return UIFont(name: familyName, size: FontSize.medium.rawValue)!
    }

    /// FontSize: 16
    static func largeFont() -> UIFont {
        return UIFont(name: familyName, size: FontSize.large.rawValue)!
    }

    /// FontSize: 18
    static func extraLargeFont() -> UIFont {
        return UIFont(name: familyName, size: FontSize.extraLarge.rawValue)!
    }
}
