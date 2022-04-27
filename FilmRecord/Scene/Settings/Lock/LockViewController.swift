//
//  LockViewController.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/27.
//  암호 잠금 화면

import Foundation
import SnapKit
import UIKit

final class LockViewController: UIViewController {
    private lazy var presenter = LockPresenter(viewController: self)

    /// Left Bar Button: 뒤로가기 버튼
    private lazy var leftBarButtonItem: UIBarButtonItem = {
        let leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrow.left"),
            style: .plain,
            target: self,
            action: #selector(didTappedLeftBarButton)
        )

        return leftBarButtonItem
    }()

    private lazy var warningLabel: UILabel = {
        let label = UILabel()
        label.text = "⚠︎ 암호를 분실하면 앱을 삭제하고 재설치 해야합니다. 재설치 시 기존 내용은 삭제됩니다."
        label.textColor = .systemRed
        label.numberOfLines = 0

        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
}

// MARK: - LockProtocol Function
extension LockViewController: LockProtocol {
    /// 화면 Appearance 설정
    func setupAppearance() {
        DarkModeManager.applyAppearance(mode: DarkModeManager.getAppearance(), viewController: self)
    }

    /// 네비게이션 바 구성
    func setupNavigationBar() {
        navigationItem.title = "암호 잠금"
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }

    /// 뷰 구성
    func setupView() {
        view.backgroundColor = .systemBackground

        [warningLabel].forEach {
            view.addSubview($0)
        }

        warningLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16.0)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16.0)
        }
    }

    /// 폰트 적용
    func applyFont() {
        let font = FontManager.getFont()

        warningLabel.font = font.mediumFont
    }

    /// 현재 뷰 pop
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - @objc Function
extension LockViewController {
    /// 뒤로 가기 버튼 클릭
    @objc func didTappedLeftBarButton() {
        presenter.didTappedLeftBarButton()
    }
}
