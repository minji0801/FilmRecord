//
//  MovieInfoVerticalStackView.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/26.
//

import UIKit

/// Fill / Fill Proportionally / 10
final class MovieInfoVerticalStackView: UIStackView {
    private let row1: UIStackView
    private let row2: UIStackView
    private let row3: UIStackView

    /// Stack View Init
    init(row1: UIStackView, row2: UIStackView, row3: UIStackView) {
        self.row1 = row1
        self.row2 = row2
        self.row3 = row3

        super.init(frame: .zero)

        axis = .vertical
        alignment = .fill
        distribution = .fill
        spacing = 8.0

        [row1, row2, row3].forEach { self.addArrangedSubview($0) }
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
