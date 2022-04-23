//
//  DarkModeTableViewCell.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/18.
//  Appearance 변경 테이블 뷰 셀

import Foundation
import SnapKit
import UIKit

final class DarkModeTableViewCell: UITableViewCell {
    static let identifier = "ThemeTableViewCell"

    let title = ["라이트 모드", "다크 모드"]

    /// 선택 버튼
    private lazy var selectButton: UIButton = {
        let button = UIButton()

        return button
    }()

    func update(_ row: Int, _ mode: Mode) {
        setupView()

        textLabel?.text = title[row]
        textLabel?.font = FontManager.largeFont()

        if (mode == .light && row == 0) || (mode == .dark && row == 1) {
            selectButton.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            selectButton.tintColor = .label
        } else {
            selectButton.setImage(UIImage(systemName: "circle"), for: .normal)
            selectButton.tintColor = .systemGray
        }
    }
}

private extension DarkModeTableViewCell {
    func setupView() {
        selectionStyle = .none

        addSubview(selectButton)

        selectButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16.0)
        }
    }
}
