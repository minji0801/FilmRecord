//
//  LockViewController.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/27.
//  암호 잠금 화면

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

    /// 경고 라벨
    private lazy var warningLabel: UILabel = {
        let label = UILabel()
        label.text = "암호를 분실하면 앱을 삭제하고 재설치 해야합니다. 재설치 시 기존 내용은 삭제됩니다."
        label.textColor = .systemRed
        label.numberOfLines = 0
        label.textAlignment = .center

        return label
    }()

    /// 화면 잠금 라벨
    private lazy var lockLabel: UILabel = {
        let label = UILabel()
        label.text = "화면 잠금"
        label.textColor = .label

        return label
    }()

    /// 화면 잠금 스위치
    private lazy var lockSwitch: UISwitch = {
        let switchButton = UISwitch()
        switchButton.isOn = false
        switchButton.addTarget(self, action: #selector(didTappedLockSwitch), for: .valueChanged)

        return switchButton
    }()

    /// 암호 변경 버튼
    private lazy var changeButton: UIButton = {
        let button = UIButton()
        button.setTitle("암호 변경", for: .normal)
        button.setTitleColor(UIColor.label, for: .normal)
        button.contentHorizontalAlignment = .leading
        button.addTarget(self, action: #selector(didTappedChangeButton), for: .touchUpInside)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        presenter.viewWillAppear()
    }
}

// MARK: - LockProtocol Function
extension LockViewController: LockProtocol {
    /// 화면 Appearance 설정
    func setupAppearance() {
        DarkModeManager.applyAppearance(mode: DarkModeManager.getAppearance(), viewController: self)
    }

    func setupNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(cancelNotification(_:)),
            name: NSNotification.Name("cancelInputPassword"),
            object: nil
        )
    }

    /// 네비게이션 바 구성
    func setupNavigationBar() {
        navigationItem.title = "암호 잠금"
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }

    /// 뷰 구성
    func setupView(_ password: String) {
        view.backgroundColor = .secondarySystemBackground

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(didTappedLeftBarButton))
        view.addGestureRecognizer(swipeLeft)

        if password.isEmpty {
            lockSwitch.isOn = false
            changeButton.isHidden = true
        } else {
            lockSwitch.isOn = true
            changeButton.isHidden = false
        }

        let horizontalStackView = UIStackView(arrangedSubviews: [lockLabel, lockSwitch])
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .fill
        horizontalStackView.distribution = .fill

        [warningLabel, horizontalStackView, changeButton].forEach {
            view.addSubview($0)
        }

        let spacing: CGFloat = 20.0

        warningLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(spacing)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(spacing)
        }

        horizontalStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(spacing)
            $0.top.equalTo(warningLabel.snp.bottom).offset(spacing)
        }

        changeButton.snp.makeConstraints {
            $0.leading.equalTo(horizontalStackView.snp.leading)
            $0.trailing.equalTo(horizontalStackView.snp.trailing)
            $0.top.equalTo(horizontalStackView.snp.bottom).offset(spacing)
        }
    }

    /// 폰트 적용
    func applyFont() {
        let font = FontManager.getFont()

        warningLabel.font = font.mediumFont
        lockLabel.font = font.largeFont
        changeButton.titleLabel?.font = font.largeFont
    }

    /// 현재 뷰 pop
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }

    /// 암호 입력 화면 보여주기
    func showInputPasswordViewController() {
        let inputPasswordviewController = InputPasswordViewController(isEntry: false)
        inputPasswordviewController.modalPresentationStyle = .fullScreen
        present(inputPasswordviewController, animated: false)
    }

    /// 화면 잠금 스위치 끄기
    func switchOff() {
        lockSwitch.setOn(false, animated: true)
    }
}

// MARK: - @objc Function
extension LockViewController {
    /// 뒤로 가기 버튼 클릭
    @objc func didTappedLeftBarButton() {
        presenter.didTappedLeftBarButton()
    }

    /// 화면 잠금 스위치 클릭
    @objc func didTappedLockSwitch() {
        presenter.didTappedLockSwitch(isOn: lockSwitch.isOn)
    }

    /// 암호 변경 버튼 클릭
    @objc func didTappedChangeButton() {
        presenter.didTappedChangeButton()
    }

    /// 암호 입력 창으로부터 취소 노티 받은 후 -> 스위치 off
    @objc func cancelNotification(_ notification: Notification) {
        presenter.cancelNotification()
    }
}
