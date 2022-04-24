//
//  AppsTableViewCell.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/01.
//  앱 테이블 뷰 셀

import UIKit

final class AppsTableViewCell: UITableViewCell {
    static let identifier = "AppsTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: AppsTableViewCell.identifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let image = ["scoit", "modakyi", "hours"]
    private let title = ["Scoit", "모닥이", "h:ours"]
    private let detail = ["스쿼트 챌린지 앱", "명언 및 모음 앱", "시간 및 디데이 계산 앱"]

    func setupCell(row: Int) {
        setupView()
        applyFont()

        imageView?.image = UIImage(named: image[row])

        textLabel?.text = title[row]
        textLabel?.textColor = .label

        detailTextLabel?.text = detail[row]
    }
}

private extension AppsTableViewCell {
    /// 뷰 구성
    func setupView() {
        backgroundColor = .clear
    }

    /// 폰트 적용
    func applyFont() {
        let font = FontManager.getFont()

        textLabel?.font = font.mediumFont
        detailTextLabel?.font = font.smallFont
    }
}
