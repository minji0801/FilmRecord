//
//  FontTableViewCell.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/23.
//  글꼴 변경 TableView Cell

import Foundation
import SnapKit
import UIKit

final class FontTableViewCell: UITableViewCell {
    static let identifier = "FontTableViewCell"

    let title = [
        "교보손글씨",
        "교보손글씨 2020 박도연",
        "이서윤체",
        "칠백삼체 유서연",
        "국립공원 꼬미",
        "봉숭아틴트",
        "고양체",
        "넥슨 배찌체",
        "국립공원 반달이"
    ]

    /// 선택 버튼
    private lazy var selectButton: UIButton = {
        let button = UIButton()

        return button
    }()

    func update(_ row: Int, _ selected: Bool) {
        setupView()

        textLabel?.text = title[row]
        textLabel?.font = Font(rawValue: row)?.largeFont

        if selected {
            selectButton.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            selectButton.tintColor = .label
        } else {
            selectButton.setImage(UIImage(systemName: "circle"), for: .normal)
            selectButton.tintColor = .systemGray
        }
    }
}

private extension FontTableViewCell {
    /// 뷰 구성
    func setupView() {
        backgroundColor = .secondarySystemBackground
        selectionStyle = .none

        addSubview(selectButton)

        selectButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16.0)
        }
    }
}
