//
//  FontViewController.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/23.
//  글꼴 변경 화면

import Foundation
import SnapKit
import UIKit

final class FontViewController: UIViewController {
    private lazy var presenter = FontPresenter(viewController: self)
    private let inset: CGFloat = 16.0
    private let cornerRadius: CGFloat = 12.0

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

    /// 글꼴 예시 세로 스택 뷰
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

        return label
    }()

    /// 영화 본 장소 라벨
    private lazy var whereTextField: UITextField = {
        let textField = UITextField()
        textField.text = "CGV"
        textField.isEnabled = false

        return textField
    }()

    /// 함께 본 사람 라벨
    private lazy var whoTextField: UITextField = {
        let textField = UITextField()
        textField.text = "친구랑"
        textField.isEnabled = false

        return textField
    }()

    /// 영화 리뷰 텍스트 뷰
    private lazy var reviewTextView: UITextView = {
        let textView = UITextView()
        textView.text = """
        (글씨체 확인을 위한 예시입니다)
        친구가 보고싶다고 해서 같이 보러갔다. 생각보다 너무 무서웠다. 아니 친구야 너가 보자며 왜 고개숙이고 안봐?-- 앞으로 절!대! 공포영화는 안볼거다!!!!!
        """
        textView.textColor = .label
        textView.isEditable = false

        return textView
    }()

    /// 테이블 뷰
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .insetGrouped)
        tableView.backgroundColor = .clear
        tableView.dataSource = presenter
        tableView.delegate = presenter

        tableView.register(
            FontTableViewCell.self,
            forCellReuseIdentifier: FontTableViewCell.identifier
        )

        return tableView
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

// MARK: - FontProtocol func
extension FontViewController: FontProtocol {
    /// 화면 Appearance 설정
    func setupAppearance() {
        DarkModeManager.applyAppearance(mode: DarkModeManager.getAppearance(), viewController: self)
    }

    /// 네비게이션 바 구성
    func setupNavigationBar() {
        navigationItem.title = "글꼴"
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }

    /// 뷰 구성
    func setupView() {
        view.backgroundColor = .secondarySystemBackground

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(didTappedLeftBarButton))
        view.addGestureRecognizer(swipeLeft)

        let placeStackView = TextFieldHorizontalStackView(title: "WHERE.", textField: whereTextField)
        let withStackView = TextFieldHorizontalStackView(title: "WITH.", textField: whoTextField)

        [verticalStactView, tableView].forEach {
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
            $0.height.equalTo(100)
        }

        tableView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(verticalStactView.snp.bottom)
        }
    }

    /// 폰트 적용
    func applyFont() {
        let font = FontManager.getFont()

        navigationController?.navigationBar.titleTextAttributes = [
            .font: font.extraLargeFont
        ]
        dateLabel.font = font.mediumFont
        whereTextField.font = font.mediumFont
        whoTextField.font = font.mediumFont
        reviewTextView.font = font.mediumFont
    }

    /// 테이블 뷰 다시 로드하기
    func reloadTableView() {
        tableView.reloadData()
    }

    /// 현재 뷰 pop
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - @objc Function
extension FontViewController {
    /// 뒤로 가기 버튼 클릭
    @objc func didTappedLeftBarButton() {
        presenter.didTappedLeftBarButton()
    }
}
