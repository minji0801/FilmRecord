//
//  threeButtonsStackView.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/28.
//  버튼이 3개 들어가는 가로 스택 뷰

import Foundation
import SnapKit
import UIKit

final class ThreeButtonStackView: UIStackView {
    private let btn1: UIButton
    private let btn2: UIButton
    private let btn3: UIButton

    init(btn1: UIButton, btn2: UIButton, btn3: UIButton) {
        self.btn1 = btn1
        self.btn2 = btn2
        self.btn3 = btn3

        super.init(frame: .zero)

        axis = .horizontal
        alignment = .fill
        distribution = .fillEqually

        setupView()
        applyFont()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ThreeButtonStackView {
    /// 뷰 구성
    func setupView() {
        [btn1, btn2, btn3].forEach {
            addArrangedSubview($0)
        }

        let height: CGFloat = 70.0

        btn1.snp.makeConstraints { $0.height.equalTo(height) }
        btn2.snp.makeConstraints { $0.height.equalTo(height) }
        btn3.snp.makeConstraints { $0.height.equalTo(height) }
    }

    /// 폰트 적용
    func applyFont() {
        let font = FontManager.getFont()

        btn1.titleLabel?.font = font.extraLargeFont
        btn2.titleLabel?.font = font.extraLargeFont
        btn3.titleLabel?.font = font.extraLargeFont
    }
}
