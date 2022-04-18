//
//  ThemeTableViewCell.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/18.
//

import Foundation
import UIKit

final class ThemeTableViewCell: UITableViewCell {
    static let identifier = "ThemeTableViewCell"

    let title = ["라이트 모드", "다크 모드"]

    func update(_ row: Int) {
        textLabel?.text = title[row]
    }
}
