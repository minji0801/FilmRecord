//
//  ReviewWriteViewController.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/27.
//  리뷰 작성 화면

import UIKit

final class ReviewWriteViewController: UIViewController {
    private var presenter: ReviewWritePresenter!
    private let inset: CGFloat = 16.0
    private let cornerRadius: CGFloat = 12.0

    init(movie: Movie, rating: Double) {
        super.init(nibName: nil, bundle: nil)
        presenter = ReviewWritePresenter(viewController: self, movie: movie, rating: rating)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 d일 EEEE"
        formatter.locale = Locale(identifier: "ko_KR")

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
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = inset

        stackView.backgroundColor = .systemBackground
        stackView.layer.cornerRadius = cornerRadius

        stackView.layer.shadowColor = UIColor.systemGray.cgColor
        stackView.layer.shadowOpacity = 0.3
        stackView.layer.shadowRadius = cornerRadius

        stackView.layoutMargins = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        stackView.isLayoutMarginsRelativeArrangement = true

        return stackView
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = formatter.string(from: Date())
        label.font = FontManager().mediumFont()
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedDateLabel)))
        label.isUserInteractionEnabled = true

        return label
    }()

    private lazy var whereTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "어디서"
        textField.font = FontManager().mediumFont()
        textField.returnKeyType = .done
        textField.delegate = presenter

        return textField
    }()

    private lazy var whoTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "누구랑"
        textField.font = FontManager().mediumFont()
        textField.returnKeyType = .done
        textField.delegate = presenter

        return textField
    }()

    private lazy var reviewTextView: UITextView = {
        let textView = UITextView()
        textView.text = "리뷰를 작성해주세요."
        textView.textColor = .systemGray3
        textView.font = FontManager().mediumFont()

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
        let dateChooserAlert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)

        dateChooserAlert.view.addSubview(datePicker)
//        dateChooserAlert.view.heightAnchor.constraint(equalToConstant: 250).isActive = true

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
        view.backgroundColor = .secondarySystemBackground
        reviewTextView.becomeFirstResponder()

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(didTappedLeftBarButton))
        view.addGestureRecognizer(swipeLeft)

        let placeStackView = TextFieldHorizontalStackView(title: "WHERE.", textField: whereTextField)
        let withStackView = TextFieldHorizontalStackView(title: "WITH.", textField: whoTextField)

        [verticalStactView].forEach {
            view.addSubview($0)
        }

        [dateLabel, placeStackView, withStackView, reviewTextView].forEach {
            verticalStactView.addArrangedSubview($0)
        }

        let spacing: CGFloat = 20.0

        verticalStactView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(spacing)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(spacing)
        }

        reviewTextView.snp.makeConstraints {
            $0.height.equalTo(150)
        }
    }

    func showDatePicker() {
        present(datePickerAlert, animated: true, completion: nil)
    }

    func keyboardDown() {
        view.endEditing(true)
    }

    func popViewController() {
        navigationController?.popViewController(animated: true)
    }

    func popToRootViewController() {
        navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - @objc Function
extension ReviewWriteViewController {

    @objc func didTappedLeftBarButton() {
        presenter.didTappedLeftBarButton()
    }

    @objc func didTappedRightBarButton() {
        // Where, who, review는 비어있을 수 있다.
        presenter.didTappedRightBarButton(
            date: dateLabel.text!,
            place: whereTextField.text ?? "",
            with: whoTextField.text ?? "",
            review: reviewTextView.text ?? ""
        )
    }

    @objc func didTappedDateLabel() {
        presenter.didTappedDateLabel()
    }
}
