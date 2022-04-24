//
//  FontTableViewCell.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/23.
//  글꼴 변경 TableView Cell

import Foundation
import UIKit

final class FontTableViewCell: UITableViewCell {
    static let identifier = "FontTableViewCell"

    let title = ["교보손글씨2019", "이서윤체"]

    func update(_ row: Int) {
        backgroundColor = .systemBackground
        textLabel?.text = title[row]
        textLabel?.font = Font(rawValue: row)?.largeFont
    }
}
