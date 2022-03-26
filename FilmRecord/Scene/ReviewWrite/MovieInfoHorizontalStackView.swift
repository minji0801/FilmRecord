//
//  MovieInfoStackView.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/26.
//

import SnapKit
import UIKit

/// Fill / Fill / 10
final class MovieInfoHorizontalStackView: UIStackView {
    private let title: String
    private let content: String

    /// 속성 제목 라벨
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: 14.0, weight: .regular)
        label.textColor = .systemGray2
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true

        return label
    }()

    /// 영화 정보 내용 라벨
    private lazy var movieInfoLabel: UILabel = {
        let label = UILabel()
        label.text = content
        label.font = .systemFont(ofSize: 14.0, weight: .medium)

        return label
    }()

    /// Stack View Init
    init(title: String, content: String) {
        self.title = title
        self.content = content

        super.init(frame: .zero)

        axis = .horizontal
        alignment = .fill
        distribution = .fill
        spacing = 10.0

        [titleLabel, movieInfoLabel].forEach { self.addArrangedSubview($0) }

        titleLabel.snp.makeConstraints { $0.width.equalTo(50.0) }
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
