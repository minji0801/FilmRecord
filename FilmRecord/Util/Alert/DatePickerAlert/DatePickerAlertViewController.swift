//
//  DatePickerAlertViewController.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/20.
//  날짜 선택 Alert 화면

import Foundation
import SnapKit
import UIKit

final class DatePickerAlertViewController: UIViewController {
    private var presenter: DatePickerAlertPresenter!

    init(date: Date) {
        super.init(nibName: nil, bundle: nil)
        presenter = DatePickerAlertPresenter(viewController: self, date: date)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 날짜 포맷
    private lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 d일 EEEE"
        formatter.locale = Locale(identifier: "ko_KR")

        return formatter
    }()

    /// Alert 뷰
    private lazy var alertView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12.0
        view.backgroundColor = .secondarySystemBackground

        return view
    }()

    /// 날짜 선택
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.preferredDatePickerStyle = .wheels

        return datePicker
    }()

    /// 선택 버튼
    private lazy var selectButton: UIButton = {
        let button = UIButton()
        button.setTitle("선택", for: .normal)
        button.setTitleColor(UIColor.label, for: .normal)
        button.titleLabel?.font = FontManager().largeFont()
        button.addTarget(self, action: #selector(didTappedSelectButton), for: .touchUpInside)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
}

// MARK: - DatePickerAlertProtocol Function
extension DatePickerAlertViewController: DatePickerAlertProtocol {
    /// 화면 Appearance 설정
    func setupAppearance() {
        DarkModeManager.applyAppearance(mode: DarkModeManager.getAppearance(), viewController: self)
    }

    /// 뷰 구성
    func setupView() {
        view.backgroundColor = .black.withAlphaComponent(0.5)
        datePicker.date = presenter.date

        view.addSubview(alertView)

        [datePicker, selectButton].forEach {
            alertView.addSubview($0)
        }

        alertView.snp.makeConstraints {
            $0.width.equalTo(250)
            $0.height.equalTo(250)
            $0.centerX.centerY.equalToSuperview()
        }

        datePicker.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(200)
        }

        selectButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(datePicker.snp.bottom)
        }
    }

    /// 현재 뷰 닫기
    func dismiss() {
        NotificationCenter.default.post(name: NSNotification.Name("DismissDatePicker"), object: datePicker.date)
        dismiss(animated: false)
    }
}

// MARK: - @objc Function
extension DatePickerAlertViewController {
    /// 선택 버튼 클릭 -> 창 닫으면서 선택한 날짜 전달
    @objc func didTappedSelectButton() {
        presenter.didTappedSelectButton()
    }
}
