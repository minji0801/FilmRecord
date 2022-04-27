//
//  InputPasswordViewController.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/28.
//  비밀번호 입력 화면

import SnapKit
import UIKit

final class InputPasswordViewController: UIViewController {
    private lazy var presenter = InputPasswordPresenter(viewController: self)

    /// 제목 라벨
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "암호 입력"
        label.textColor = .label

        return label
    }()

    /// 설명 라벨
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "암호를 입력해주세요."
        label.textColor = .secondaryLabel

        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
}

extension InputPasswordViewController: InputPasswordProtocol {
    /// 화면 Appearance 설정
    func setupAppearance() {
        DarkModeManager.applyAppearance(mode: DarkModeManager.getAppearance(), viewController: self)
    }

    /// 뷰 구성
    func setupView() {
        view.backgroundColor = .systemBackground

        let topStackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        topStackView.axis = .vertical
        topStackView.alignment = .center
        topStackView.distribution = .fill

        [topStackView].forEach {
            view.addSubview($0)
        }

        topStackView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }

    /// 폰트 적용
    func applyFont() {
        let font = FontManager.getFont()

        titleLabel.font = font.twoExtraLargeFont
        descriptionLabel.font = font.mediumFont
    }
}
