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

enum FamilyName: String {
    case gangwon = "GangwonEduSaeeum-OTFMedium" // 강원교육새음
    case ownglyph = "OwnglyphMinhyeChae"        // 온글잎 민혜체
    case kyobo = "KyoboHandwriting2019"         // 교보손글씨2019
    case leeseoyun = "LeeSeoyun"                // 이서윤체

//    var basicFont: UIFont {
//        switch self {
//        case .gangwon:
//            return UIFont(name: self.rawValue, size: FontSize.basic.rawValue)!
//        case .ownglyph:
//            return UIFont(name: self.rawValue, size: FontSize.basic.rawValue)!
//        case .kyobo:
//            return UIFont(name: self.rawValue, size: FontSize.basic.rawValue)!
//        case .leeseoyun:
//            return UIFont(name: self.rawValue, size: FontSize.basic.rawValue)!
//        }
//    }
}

class FontManager {
    static let familyName = FamilyName.leeseoyun.rawValue

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
