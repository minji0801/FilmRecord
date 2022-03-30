//
//  TextFieldHorizontalStackView.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/27.
//  텍스트 필드를 포함한 가로 스택 뷰
//  ex. 이미지 | 텍스트 필드

import SnapKit
import UIKit

/// Fill / Fill / 10
final class TextFieldHorizontalStackView: UIStackView {
    private let title: String
    private let textField: UITextField

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = title
        label.font = FontManager().mediumFont()
        label.textColor = .systemGray2
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true

        return label
    }()

    init(title: String, textField: UITextField) {
        self.title = title
        self.textField = textField

        super.init(frame: .zero)

        axis = .horizontal
        alignment = .fill
        distribution = .fill
        spacing = 10.0

        [titleLabel, textField].forEach { self.addArrangedSubview($0) }

        titleLabel.snp.makeConstraints { $0.width.equalTo(55.0) }
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UITextFieldDelegate
extension TextFieldHorizontalStackView: UITextFieldDelegate {
    /// Text Felid Return 클릭: 키보드 내리기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
