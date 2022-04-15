//
//  AppsTableViewCell.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/01.
//  앱 테이블 뷰 셀

import UIKit

final class AppsTableViewCell: UITableViewCell {
    static let identifier = "AppsTableViewCell"

    private let image = ["scoit", "modakyi", "hours"]
    private let title = ["Scoit - 스쿼트 챌린지 앱", "모닥이 - 글귀 & 명언 모음 앱", "h:ours - 시간 & 디데이 계산 앱"]

    func setupCell(row: Int) {
        textLabel?.text = title[row]
        textLabel?.numberOfLines = 0
        textLabel?.font = .systemFont(ofSize: 14.0, weight: .regular)
        textLabel?.textColor = .label
//        textLabel?.font = FontManager().largeFont()

        imageView?.image = UIImage(named: image[row])

        backgroundColor = .clear
    }
}
