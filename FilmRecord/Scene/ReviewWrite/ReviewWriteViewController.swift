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

    init(movie: Movie, rating: Double, review: Review, isEditing: Bool) {
        super.init(nibName: nil, bundle: nil)
        presenter = ReviewWritePresenter(
            viewController: self,
            movie: movie,
            rating: rating,
            review: review,
            isEditing: isEditing
        )
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

    /// Right Bar Button: 체크 버튼
    private lazy var rightBarButtonItem: UIBarButtonItem = {
        let rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "checkmark"),
            style: .plain,
            target: self,
            action: #selector(didTappedRightBarButton)
        )

        return rightBarButtonItem
    }()

    /// 세로 스택 뷰
    private lazy var verticalStactView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = inset

        stackView.backgroundColor = .systemBackground
        stackView.layer.cornerRadius = cornerRadius

        stackView.layer.shadowColor = UIColor.black.cgColor
        stackView.layer.shadowOpacity = 0.2
        stackView.layer.shadowRadius = cornerRadius
        stackView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)

        stackView.layoutMargins = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        stackView.isLayoutMarginsRelativeArrangement = true

        return stackView
    }()

    /// 날짜 라벨
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = formatter.string(from: Date())
        label.font = FontManager().mediumFont()
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedDateLabel)))
        label.isUserInteractionEnabled = true

        return label
    }()

    /// 영화 본 장소 라벨
    private lazy var whereTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "어디서"
        textField.font = FontManager().mediumFont()
        textField.returnKeyType = .done
        textField.delegate = presenter

        return textField
    }()

    /// 함께 본 사람 라벨
    private lazy var whoTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "누구랑"
        textField.font = FontManager().mediumFont()
        textField.returnKeyType = .done
        textField.delegate = presenter

        return textField
    }()

    /// 영화 리뷰 텍스트 뷰
    private lazy var reviewTextView: UITextView = {
        let textView = UITextView()
        textView.text = "리뷰를 작성해주세요."
        textView.textColor = .systemGray3
        textView.font = FontManager().mediumFont()

        textView.delegate = presenter

        return textView
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
    /// 화면 Appearance 설정
    func setupAppearance() {
        DarkModeManager.applyAppearance(mode: DarkModeManager.getAppearance(), viewController: self)
    }

    /// 네비게이션 바 구성
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    /// 노티피케이션 구성
    func setupNoti() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didDismissDatePickerAlert(_:)),
            name: NSNotification.Name("DismissDatePicker"),
            object: nil
        )
    }

    /// 뷰 구성
    func setupView(review: Review, isEditing: Bool) {
        view.backgroundColor = .secondarySystemBackground

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(didTappedLeftBarButton))
        view.addGestureRecognizer(swipeLeft)

        if isEditing {
            dateLabel.text = review.date
            whereTextField.text = review.place
            whoTextField.text = review.with
            reviewTextView.text = review.review
            reviewTextView.textColor = .label
        }

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
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }

        reviewTextView.snp.makeConstraints {
            $0.height.equalTo(150)
        }
    }

    /// 날짜 선택 창 보여주기
    func showDatePickerAlertViewController() {
        let datePickerAlertViewController = DatePickerAlertViewController(date: formatter.date(from: dateLabel.text!)!)
        datePickerAlertViewController.modalPresentationStyle = .overCurrentContext
        present(datePickerAlertViewController, animated: false)
    }

    /// 키보드 내리기
    func keyboardDown() {
        view.endEditing(true)
    }

    /// 현재 뷰 pop
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }

    /// 루트 뷰로 이동
    func popToRootViewController() {
        navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - @objc Function
extension ReviewWriteViewController {
    /// 뒤로 가기 버튼 클릭 -> 현재 뷰 pop
    @objc func didTappedLeftBarButton() {
        presenter.didTappedLeftBarButton()
    }

    /// 체크 버튼 클릭 -> 리뷰 저장하기
    @objc func didTappedRightBarButton() {
        // Where, who, review는 비어있을 수 있다.
        presenter.didTappedRightBarButton(
            date: dateLabel.text!,
            place: whereTextField.text ?? "",
            with: whoTextField.text ?? "",
            content: reviewTextView.text ?? ""
        )
    }

    /// 날짜 라벨 클릭 -> DatePickerAlert 띄우기
    @objc func didTappedDateLabel() {
        presenter.didTappedDateLabel()
    }

    /// 데이트피커 사라지고 받는 노티
    @objc func didDismissDatePickerAlert(_ notification: Notification) {
        guard let object: Date = notification.object as? Date else { return }

        let date = formatter.string(from: object)
        dateLabel.text = date
    }
}
