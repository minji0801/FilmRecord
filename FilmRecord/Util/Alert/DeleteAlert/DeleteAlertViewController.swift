//
//  DeleteAlertViewController.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/31.
//  리뷰 삭제 Alert 화면

import Foundation
import SnapKit
import UIKit

final class DeleteAlertViewController: UIViewController {
    private lazy var presenter = DeleteAlertPresenter(viewController: self)

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
        label.text = """
                    정말 삭제하시겠습니까?
                    (삭제 후 내용을 복원할 수 없습니다)
                    """
        label.textAlignment = .center
        label.font = FontManager.largeFont()
        label.numberOfLines = 0

        return label
    }()

    /// 버튼 가로 스택 뷰
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill

        return stackView
    }()

    /// 취소 버튼
    private lazy var cancleButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(UIColor.label, for: .normal)
        button.titleLabel?.font = FontManager.largeFont()
        button.addTarget(self, action: #selector(didTappedCancleButton), for: .touchUpInside)

        return button
    }()

    /// 삭제 버튼
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("삭제", for: .normal)
        button.setTitleColor(UIColor.systemRed, for: .normal)
        button.titleLabel?.font = FontManager.largeFont()
        button.addTarget(self, action: #selector(didTappedDeleteButton), for: .touchUpInside)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
}

// MARK: - DeleteAlertProtocol Function
extension DeleteAlertViewController: DeleteAlertProtocol {

    /// 화면 Appearance 설정
    func setupAppearance() {
        DarkModeManager.applyAppearance(mode: DarkModeManager.getAppearance(), viewController: self)
    }

    /// 뷰 구성
    func setupView() {
        view.backgroundColor = .black.withAlphaComponent(0.5)

        view.addSubview(alertView)

        [messageLabel, buttonStackView].forEach {
            alertView.addSubview($0)
        }

        [cancleButton, deleteButton].forEach {
            buttonStackView.addArrangedSubview($0)
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

    /// 현재 뷰 닫기
    func dismiss() {
        dismiss(animated: false)
    }

    /// 삭제 노티피케이션 송신
    func postDeleteNotification() {
        NotificationCenter.default.post(name: NSNotification.Name("DeleteReview"), object: nil)
    }
}

// MARK: - @objc Function
extension DeleteAlertViewController {
    /// 취소 버튼 클릭 -> 창 닫기
    @objc func didTappedCancleButton() {
        presenter.didTappedCancleButton()
    }

    /// 삭제 버튼 클릭 -> DetailViewController로 노티피케이션 보내기
    @objc func didTappedDeleteButton() {
        presenter.didTappedDeleteButton()
    }
}
