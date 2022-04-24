//
//  LabelHorizontalStackView.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/26.
//  라벨을 포함한 가로 스택 뷰

import SnapKit
import UIKit

final class LabelHorizontalStackView: UIStackView {
    private let title: String
    private let content: String

    /// 제목 라벨
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = title
        label.textColor = .systemGray2
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true

        return label
    }()

    /// 내용 라벨
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = content
        label.numberOfLines = 0

        return label
    }()

    init(title: String, content: String) {
        self.title = title
        self.content = content

        super.init(frame: .zero)

        axis = .horizontal
        alignment = .top
        distribution = .fill
        spacing = 10.0

        setupView()
        applyFont()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension LabelHorizontalStackView {
    /// 뷰 구성
    func setupView() {
        [titleLabel, textLabel].forEach {
            addArrangedSubview($0)
        }

        titleLabel.snp.makeConstraints {
            $0.width.equalTo(70.0)
        }
    }

    /// 폰트 적용
    func applyFont() {
        let font = FontManager.getFont()

        titleLabel.font = font.mediumFont
        textLabel.font = font.mediumFont
    }
}
