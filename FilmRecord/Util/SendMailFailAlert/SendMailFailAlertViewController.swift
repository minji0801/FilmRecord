//
//  SendMailFailAlert.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/16.
//  메일 전송 실패 Alert

import Foundation
import SnapKit
import UIKit

final class SendMailFailAlertViewController: UIViewController {
    private lazy var presenter = SendMailFailPresenter(viewController: self)

    /// Alert 뷰
    private lazy var alertView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12.0
        view.backgroundColor = .secondarySystemBackground

        return view
    }()

    /// 메세지 라벨
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "App Store에서 'Mail' 앱을 복원하거나 [설정 > Mail > 계정]을 확인하고 다시 시도해주세요."
        label.textAlignment = .center
        label.numberOfLines = 0

        return label
    }()

    /// 닫기 버튼
    private lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.setTitle("닫기", for: .normal)
        button.setTitleColor(UIColor.label, for: .normal)
        button.addTarget(self, action: #selector(didTappedDismissButton), for: .touchUpInside)

        return button
    }()

    /// 이동 버튼
    private lazy var moveButton: UIButton = {
        let button = UIButton()
        button.setTitle("이동", for: .normal)
        button.setTitleColor(UIColor.systemRed, for: .normal)
        button.addTarget(self, action: #selector(didTappedMoveButton), for: .touchUpInside)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
}

// MARK: - SendMailFailProtocol Function
extension SendMailFailAlertViewController: SendMailFailProtocol {
    /// 화면 Appearance 설정
    func setupAppearance() {
        DarkModeManager.applyAppearance(mode: DarkModeManager.getAppearance(), viewController: self)
    }

    /// 뷰 구성
    func setupView() {
        view.backgroundColor = .black.withAlphaComponent(0.5)
        view.addSubview(alertView)

        /// 버튼 가로 스택 뷰
        let buttonStackView = UIStackView(arrangedSubviews: [dismissButton, moveButton])
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillProportionally
        buttonStackView.alignment = .fill

        [messageLabel, buttonStackView].forEach {
            alertView.addSubview($0)
        }

        alertView.snp.makeConstraints {
            $0.width.equalTo(250)
            $0.height.equalTo(150)
            $0.centerX.centerY.equalToSuperview()
        }

        messageLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(10.0)
        }

        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(messageLabel.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(50)

        }
    }

    /// 폰트 적용
    func applyFont() {
        let font = FontManager.getFont()
        
        messageLabel.font = font.largeFont
        dismissButton.titleLabel?.font = font.largeFont
        moveButton.titleLabel?.font = font.largeFont
    }

    /// 현재 뷰 닫기
    func dismiss() {
        dismiss(animated: false)
    }

    /// 앱스토어로 이동
    func goToAppStore() {
        let store = "https://apps.apple.com/kr/app/mail/id1108187098"
        if let url = URL(string: store), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}

// MARK: - @objc Function
extension SendMailFailAlertViewController {
    /// 닫기 버튼 클릭 -> 창 닫기
    @objc func didTappedDismissButton() {
        presenter.didTappedDismissButton()
    }

    /// 이동 버튼 클릭 -> 앱스토어로 이동(Mail 앱)
    @objc func didTappedMoveButton() {
        presenter.didTappedMoveButton()
    }
}
