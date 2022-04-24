//
//  PopUpViewController.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/30.
//  팝업(수정, 삭제) 화면

import SnapKit
import UIKit

final class PopUpViewController: UIViewController {
    private var presenter: PopUpPresenter!

    init(review: Review) {
        super.init(nibName: nil, bundle: nil)
        presenter = PopUpPresenter(viewController: self, review: review)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 세로 스택 뷰: 수정 버튼, 삭제 버튼
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill

        return stackView
    }()

    /// 수정 버튼
    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.setTitle("수정", for: .normal)
        button.setTitleColor(UIColor.label, for: .normal)
        button.addTarget(self, action: #selector(didTappedEditButton), for: .touchUpInside)

        return button
    }()

    /// 삭제 버튼
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("삭제", for: .normal)
        button.setTitleColor(UIColor.systemRed, for: .normal)
        button.addTarget(self, action: #selector(didTappedDeleteButton), for: .touchUpInside)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
}

// MARK: - PopUpProtocol Function
extension PopUpViewController: PopUpProtocol {
    /// 화면 Appearance 설정
    func setupAppearance() {
        DarkModeManager.applyAppearance(mode: DarkModeManager.getAppearance(), viewController: self)
    }

    /// 뷰 구성
    func setupView() {
        view.backgroundColor = .secondarySystemBackground

        view.addSubview(verticalStackView)

        [editButton, deleteButton].forEach {
            verticalStackView.addArrangedSubview($0)
        }

        verticalStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func applyFont() {
        let font = FontManager.getFont()

        editButton.titleLabel?.font = font.largeFont
        deleteButton.titleLabel?.font = font.largeFont
    }

    /// 수정 노티피케이션 송신
    func postEditNotification() {
        dismiss(animated: true)
        NotificationCenter.default.post(name: NSNotification.Name("Edit"), object: nil)
    }

    /// 삭제 노티피케이션 송신
    func postDeleteNotification() {
        dismiss(animated: true)
        NotificationCenter.default.post(name: NSNotification.Name("Delete"), object: nil)
    }
}

// MARK: - @objc Function
extension PopUpViewController {
    /// 수정 버튼 클릭 -> DetailViewController로 노티피케이션 송신
    @objc func didTappedEditButton() {
        presenter.didTappedEditButton()
    }

    /// 삭제 버튼 클릭 -> DetailViewController로 노티피케이션 송신
    @objc func didTappedDeleteButton() {
        presenter.didTappedDeleteButton()
    }
}
