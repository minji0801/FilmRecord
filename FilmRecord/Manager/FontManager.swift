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
    case extraLarge = 20
    case twoExtraLarge = 25
}

enum Font: Int {
    case kyobo          // 교보손글씨
    case kyobo2020      // 교보손글씨2020
    case leeseoyun      // 이서윤체
    case no703          // 칠백삼체 유서연
    case komi           // 국립공원 꼬미
    case balsamtint     // 봉숭아틴트
    case goyang         // 고양체
    case bazzi          // 넥슨 배찌체
    case bandali        // 국립공원 반달이

    static let allValues = [
        kyobo,
        kyobo2020,
        leeseoyun,
        no703,
        komi,
        balsamtint,
        goyang,
        bazzi,
        bandali
    ]

    /// 아이폰 글씨(size: 12)
    var smallFont: UIFont {
        switch self {
        case .kyobo:
            return UIFont(name: "KyoboHandwriting2019", size: FontSize.small.rawValue)!
        case .kyobo2020:
            return UIFont(name: "KyoboHandwriting2020", size: FontSize.small.rawValue)!
        case .leeseoyun:
            return UIFont(name: "LeeSeoyun", size: FontSize.small.rawValue)!
        case .no703:
            return UIFont(name: "establishRoomNo703OTF", size: FontSize.small.rawValue)!
        case .komi:
            return UIFont(name: "KNPSKkomi-Regular", size: FontSize.small.rawValue)!
        case .balsamtint:
            return UIFont(name: "777Balsamtint", size: FontSize.small.rawValue)!
        case .goyang:
            return UIFont(name: "Goyang", size: FontSize.small.rawValue)!
        case .bazzi:
            return UIFont(name: "BazziOTFRegular", size: FontSize.small.rawValue)!
        case .bandali:
            return UIFont(name: "KNPSBandali-Regular", size: FontSize.small.rawValue)!
        }
    }

    /// 아이폰 글씨(size: 14)
    var mediumFont: UIFont {
        switch self {
        case .kyobo:
            return UIFont(name: "KyoboHandwriting2019", size: FontSize.medium.rawValue)!
        case .kyobo2020:
            return UIFont(name: "KyoboHandwriting2020", size: FontSize.medium.rawValue)!
        case .leeseoyun:
            return UIFont(name: "LeeSeoyun", size: FontSize.medium.rawValue)!
        case .no703:
            return UIFont(name: "establishRoomNo703OTF", size: FontSize.medium.rawValue)!
        case .komi:
            return UIFont(name: "KNPSKkomi-Regular", size: FontSize.medium.rawValue)!
        case .balsamtint:
            return UIFont(name: "777Balsamtint", size: FontSize.medium.rawValue)!
        case .goyang:
            return UIFont(name: "Goyang", size: FontSize.medium.rawValue)!
        case .bazzi:
            return UIFont(name: "BazziOTFRegular", size: FontSize.medium.rawValue)!
        case .bandali:
            return UIFont(name: "KNPSBandali-Regular", size: FontSize.medium.rawValue)!
        }
    }

    /// 아이폰 글씨(size: 16)
    var largeFont: UIFont {
        switch self {
        case .kyobo:
            return UIFont(name: "KyoboHandwriting2019", size: FontSize.large.rawValue)!
        case .kyobo2020:
            return UIFont(name: "KyoboHandwriting2020", size: FontSize.large.rawValue)!
        case .leeseoyun:
            return UIFont(name: "LeeSeoyun", size: FontSize.large.rawValue)!
        case .no703:
            return UIFont(name: "establishRoomNo703OTF", size: FontSize.large.rawValue)!
        case .komi:
            return UIFont(name: "KNPSKkomi-Regular", size: FontSize.large.rawValue)!
        case .balsamtint:
            return UIFont(name: "777Balsamtint", size: FontSize.large.rawValue)!
        case .goyang:
            return UIFont(name: "Goyang", size: FontSize.large.rawValue)!
        case .bazzi:
            return UIFont(name: "BazziOTFRegular", size: FontSize.large.rawValue)!
        case .bandali:
            return UIFont(name: "KNPSBandali-Regular", size: FontSize.large.rawValue)!
        }
    }

    /// 아이폰 글씨(size: 18)
    var extraLargeFont: UIFont {
        switch self {
        case .kyobo:
            return UIFont(name: "KyoboHandwriting2019", size: FontSize.extraLarge.rawValue)!
        case .kyobo2020:
            return UIFont(name: "KyoboHandwriting2020", size: FontSize.extraLarge.rawValue)!
        case .leeseoyun:
            return UIFont(name: "LeeSeoyun", size: FontSize.extraLarge.rawValue)!
        case .no703:
            return UIFont(name: "establishRoomNo703OTF", size: FontSize.extraLarge.rawValue)!
        case .komi:
            return UIFont(name: "KNPSKkomi-Regular", size: FontSize.extraLarge.rawValue)!
        case .balsamtint:
            return UIFont(name: "777Balsamtint", size: FontSize.extraLarge.rawValue)!
        case .goyang:
            return UIFont(name: "Goyang", size: FontSize.extraLarge.rawValue)!
        case .bazzi:
            return UIFont(name: "BazziOTFRegular", size: FontSize.extraLarge.rawValue)!
        case .bandali:
            return UIFont(name: "KNPSBandali-Regular", size: FontSize.extraLarge.rawValue)!
        }
    }

    /// 아이폰 글씨(size: 20)
    var twoExtraLargeFont: UIFont {
        switch self {
        case .kyobo:
            return UIFont(name: "KyoboHandwriting2019", size: FontSize.twoExtraLarge.rawValue)!
        case .kyobo2020:
            return UIFont(name: "KyoboHandwriting2020", size: FontSize.twoExtraLarge.rawValue)!
        case .leeseoyun:
            return UIFont(name: "LeeSeoyun", size: FontSize.twoExtraLarge.rawValue)!
        case .no703:
            return UIFont(name: "establishRoomNo703OTF", size: FontSize.twoExtraLarge.rawValue)!
        case .komi:
            return UIFont(name: "KNPSKkomi-Regular", size: FontSize.twoExtraLarge.rawValue)!
        case .balsamtint:
            return UIFont(name: "777Balsamtint", size: FontSize.twoExtraLarge.rawValue)!
        case .goyang:
            return UIFont(name: "Goyang", size: FontSize.twoExtraLarge.rawValue)!
        case .bazzi:
            return UIFont(name: "BazziOTFRegular", size: FontSize.twoExtraLarge.rawValue)!
        case .bandali:
            return UIFont(name: "KNPSBandali-Regular", size: FontSize.twoExtraLarge.rawValue)!
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
            return .kyobo
        }
    }
    /// 폰트 저장하기
    static func setFont(font: Font) {
        UserDefaults.standard.setValue(font.rawValue, forKey: fontKey)
        UserDefaults.standard.synchronize()
    }
}
