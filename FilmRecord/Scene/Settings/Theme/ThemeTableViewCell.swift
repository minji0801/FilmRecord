//
//  ThemeTableViewCell.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/18.
//

import Foundation
import SnapKit
import UIKit

final class ThemeTableViewCell: UITableViewCell {
    static let identifier = "ThemeTableViewCell"

    let title = ["라이트 모드", "다크 모드"]

    /// 선택 버튼
    private lazy var selectButton: UIButton = {
        let button = UIButton()

        return button
    }()

    func update(_ row: Int) {
        setupView()

        textLabel?.text = title[row]
        textLabel?.font = FontManager().largeFont()

        selectButton.setImage(UIImage(systemName: "circle"), for: .normal)
        selectButton.tintColor = .systemGray
    }
}

private extension ThemeTableViewCell {
    func setupView() {
        selectionStyle = .none

        addSubview(selectButton)

        selectButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16.0)
        }
    }
}
