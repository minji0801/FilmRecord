//
//  ReviewWriteViewController.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/27.
//  리뷰 작성 화면

import UIKit

final class ReviewWriteViewController: UIViewController {
    private lazy var presenter = ReviewWritePresenter(viewController: self)

    private lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 d일 E요일"
        return formatter
    }()

    private lazy var leftBarButtonItem: UIBarButtonItem = {
        let leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrow.left"),
            style: .plain,
            target: self,
            action: #selector(didTappedLeftBarButton)
        )

        return leftBarButtonItem
    }()

    private lazy var rightBarButtonItem: UIBarButtonItem = {
        let rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "checkmark"),
            style: .plain,
            target: self,
            action: #selector(didTappedRightBarButton)
        )

        return rightBarButtonItem
    }()

    private lazy var verticalStactView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 16.0

        return stackView
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = formatter.string(from: Date())
        label.font = .boldSystemFont(ofSize: 14.0)
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedDateLabel)))
        label.isUserInteractionEnabled = true

        return label
    }()

    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.text = "리뷰를 작성해주세요."
        textView.textColor = .systemGray3
        textView.font = .systemFont(ofSize: 14.0, weight: .regular)

        textView.layer.cornerRadius = 5.0
        textView.layer.borderWidth = 0.6
        textView.layer.borderColor = UIColor.systemGray5.cgColor

        textView.delegate = presenter

        return textView
    }()

    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.preferredDatePickerStyle = .wheels

        return datePicker
    }()

    private lazy var datePickerAlert: UIAlertController = {
        let dateChooserAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        dateChooserAlert.view.addSubview(datePicker)
        dateChooserAlert.view.heightAnchor.constraint(equalToConstant: 250).isActive = true

        datePicker.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-20)
        }

        dateChooserAlert.addAction(UIAlertAction(title: "선택", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            let date = self.formatter.string(from: self.datePicker.date)
            self.dateLabel.text = date
        }))

        return dateChooserAlert
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        presenter.touchesBegan()
    }
}

extension ReviewWriteViewController: ReviewWriteProtocol {
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    func setupView() {
        let placeStackView = TextFieldHorizontalStackView(title: "WHERE.", placehorder: "어디서")
        let withStackView = TextFieldHorizontalStackView(title: "WITH.", placehorder: "누구랑")

        [verticalStactView, textView].forEach {
            view.addSubview($0)
        }

        [dateLabel, placeStackView, withStackView].forEach {
            verticalStactView.addArrangedSubview($0)
        }

        let spacing: CGFloat = 20.0

        verticalStactView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(spacing)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(spacing)
        }

        textView.snp.makeConstraints {
            $0.leading.equalTo(verticalStactView.snp.leading)
            $0.trailing.equalTo(verticalStactView.snp.trailing)
            $0.top.equalTo(verticalStactView.snp.bottom).offset(spacing)
            $0.height.equalTo(150)
        }
    }

    func showDatePicker() {
        present(datePickerAlert, animated: true, completion: nil)
    }

    func keyboardDown() {
        view.endEditing(true)
    }
}

// MARK: - @objc Function
extension ReviewWriteViewController {

    @objc func didTappedLeftBarButton() {
        presenter.didTappedLeftBarButton()
    }

    @objc func didTappedRightBarButton() {
        presenter.didTappedRightBarButton()
    }

    @objc func didTappedDateLabel() {
        presenter.didTappedDateLabel()
    }
}
