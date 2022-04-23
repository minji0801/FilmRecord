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
    case gangwon    // 강원교육새음
    case kyobo      // 교보손글씨2019
    case ownglyph   // 온글잎 민혜체
    case leeseoyun  // 이서윤체

    static let allValues = [gangwon, kyobo, ownglyph, leeseoyun]

    /// 아이폰 작은 글씨(size: 12)
    var smallFont: UIFont {
        switch self {
        case .gangwon:
            return UIFont(name: "GangwonEduSaeeum-OTFMedium", size: FontSize.small.rawValue)!
        case .kyobo:
            return UIFont(name: "KyoboHandwriting2019", size: FontSize.small.rawValue)!
        case .ownglyph:
            return UIFont(name: "OwnglyphMinhyeChae", size: FontSize.small.rawValue)!
        case .leeseoyun:
            return UIFont(name: "LeeSeoyun", size: FontSize.small.rawValue)!
        }
    }
}

class FontManager {
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
