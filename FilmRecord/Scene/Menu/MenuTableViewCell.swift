//
//  MenuTableViewCell.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/01.
//  메뉴 테이블 뷰 셀

import UIKit

final class MenuTableViewCell: UITableViewCell {
    static let identifier = "MenuTableViewCell"

    private let image = ["book.closed", "calendar", "heart", "film", "gearshape"]
    private let title = ["영화 기록장", "리뷰 캘린더", "좋아하는 영화", "보고 싶은 영화", "설정" ]

    func setupCell(row: Int) {
        setupView()
        applyFont()

        imageView?.image = UIImage(systemName: image[row])
        imageView?.tintColor = .label

        textLabel?.text = title[row]
    }
}

private extension MenuTableViewCell {
    /// 뷰 구성
    func setupView() {
        backgroundColor = .clear
    }

    /// 폰트 적용
    func applyFont() {
        let font = FontManager.getFont()

        textLabel?.font = font.extraLargeFont
    }
}
