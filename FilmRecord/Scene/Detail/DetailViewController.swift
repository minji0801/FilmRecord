//
//  DetailViewController.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/29.
//  리뷰 상세 화면

import Cosmos
import UIKit

class DetailViewController: UIViewController {
    private var presenter: DetailPresenter!
    private let inset: CGFloat = 16.0
    private let cornerRadius: CGFloat = 12.0

    init(review: Review) {
        super.init(nibName: nil, bundle: nil)
        presenter = DetailPresenter(viewController: self, review: review)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 시간 포맷
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

    /// Right Bar Button: ... 버튼
    private lazy var rightBarButtonItem: UIBarButtonItem = {
        let rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "ellipsis"),
            style: .plain,
            target: self,
            action: #selector(didTappedRightBarButton(_:))
        )

        return rightBarButtonItem
    }()

    /// 상단 가로 스택 뷰: 영화 썸네일 이미지, 영화 제목, 사용자 평점 (카드 형태로 구성)
    private lazy var topHorizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
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

    /// 상단 세로 스택 뷰: 영화 제목, 사용자 평점
    private lazy var topVerticalStactView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = inset

        return stackView
    }()

    /// 영화 썸네일 이미지
    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    /// 중간 선
    private lazy var separatorLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray

        return view
    }()

    /// 영화 제목 라벨
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = FontManager().extraLargeFont()
        label.textAlignment = .center
        label.numberOfLines = 3

        return label
    }()

    /// 사용자 평점 뷰
    private lazy var ratingView: CosmosView = {
        let cosmosView = CosmosView()
        cosmosView.settings.starSize = 30
        cosmosView.settings.starMargin = 0
        cosmosView.settings.fillMode = .full

        cosmosView.settings.updateOnTouch = false

        cosmosView.settings.filledImage = UIImage(named: "star.fill")
        cosmosView.settings.emptyImage = UIImage(named: "star")

        return cosmosView
    }()

    /// 하단 세로 스택 뷰: 영화 정보, 리뷰 정보
    private lazy var bottomVerticalStactView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = inset

        return stackView
    }()

    /// 리뷰 텍스트 뷰
    private lazy var reviewTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .label
        textView.font = FontManager().mediumFont()
        textView.backgroundColor = .clear
        textView.isEditable = false

        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
}

// MARK: - DetailProtocol Function
extension DetailViewController: DetailProtocol {
    /// 네비게이션 바 구성
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    /// 노티피케이션 구성
    func setupNoti() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(editNotification(_:)),
            name: NSNotification.Name("Edit"),
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(deleteNotification(_:)),
            name: NSNotification.Name("Delete"),
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(deleteReviewNotification(_:)),
            name: NSNotification.Name("DeleteReview"),
            object: nil
        )
    }

    /// 뷰 구성
    func setupView(review: Review) {
        view.backgroundColor = .secondarySystemBackground

        // 뒤로가기 제스처 등록
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(didTappedLeftBarButton))
        view.addGestureRecognizer(swipeLeft)

        thumbnailImageView.kf.setImage(with: review.movie.imageURL)
        titleLabel.text = review.movie.title.htmlEscaped
        ratingView.rating = review.rating

        let yearStackView = LabelHorizontalStackView(title: "YEAR.", content: review.movie.pubDate)
        let directorStackView = LabelHorizontalStackView(title: "DIRECTOR.", content: review.movie.director.withComma)
        let castStackView = LabelHorizontalStackView(title: "ACTOR.", content: review.movie.actor.withComma)
        let infoStackView = ThreeRowVerticalStackView(row1: yearStackView, row2: directorStackView, row3: castStackView)

        let dateStackView = LabelHorizontalStackView(title: "WHEN.", content: review.date)
        let placeStackView = LabelHorizontalStackView(title: "WHERE.", content: review.place)
        let withStackView = LabelHorizontalStackView(title: "WITH.", content: review.with)
        let reviewStackView = ThreeRowVerticalStackView(row1: dateStackView, row2: placeStackView, row3: withStackView)

        reviewTextView.text = review.review

        [topHorizontalStackView, infoStackView, bottomVerticalStactView, reviewTextView].forEach {
            view.addSubview($0)
        }

        [thumbnailImageView, separatorLineView, topVerticalStactView].forEach {
            topHorizontalStackView.addArrangedSubview($0)
        }

        [titleLabel, ratingView].forEach {
            topVerticalStactView.addArrangedSubview($0)
        }

        [infoStackView, reviewStackView].forEach {
            bottomVerticalStactView.addArrangedSubview($0)
        }

        let spacing: CGFloat = 20.0

        topHorizontalStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(spacing)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(spacing)
        }

        thumbnailImageView.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(thumbnailImageView.snp.width).multipliedBy(1.5)
        }

        separatorLineView.snp.makeConstraints { $0.width.equalTo(0.2) }

        bottomVerticalStactView.snp.makeConstraints {
            $0.leading.equalTo(topHorizontalStackView.snp.leading)
            $0.trailing.equalTo(topHorizontalStackView.snp.trailing)
            $0.top.equalTo(topHorizontalStackView.snp.bottom).offset(spacing)
        }

        reviewTextView.snp.makeConstraints {
            $0.leading.equalTo(bottomVerticalStactView.snp.leading)
            $0.trailing.equalTo(bottomVerticalStactView.snp.trailing)
            $0.top.equalTo(bottomVerticalStactView.snp.bottom).offset(spacing)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(spacing)
        }
    }

    /// 현재 뷰 pop
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }

    /// 영화 평점 입력 화면 push
    func pushToEnterRatingViewController() {
        let review = presenter.review
        let enterRagingViewController = EnterRatingViewController(
            movie: review.movie,
            review: review,
            isEditing: true
        )
        navigationController?.pushViewController(enterRagingViewController, animated: true)
    }

    /// 삭제 Alert 창 보여주기
    func showDeleteAlert() {
        let deleteAlertViewController = DeleteAlertViewController()
        deleteAlertViewController.modalPresentationStyle = .overCurrentContext
        present(deleteAlertViewController, animated: false)
    }
}

// MARK: - @objc Function
extension DetailViewController {

    /// 뒤로 가기 버튼 클릭 -> 현재 뷰 pop
    @objc func didTappedLeftBarButton() {
        presenter.didTappedLeftBarButton()
    }

    /// ... 버튼 클릭 -> 수정/삭제 팝업 창 보여주기
    @objc func didTappedRightBarButton(_ sender: UIBarButtonItem) {
        let popoverContentController = PopUpViewController(review: presenter.review)
        popoverContentController.modalPresentationStyle = .popover
        popoverContentController.preferredContentSize = CGSize(width: 80, height: 100)

        if let popoverPresentationController = popoverContentController.popoverPresentationController {
            popoverPresentationController.permittedArrowDirections = .right
            popoverPresentationController.barButtonItem = sender
            popoverPresentationController.delegate = self
            present(popoverContentController, animated: true, completion: nil)
        }
    }

    /// 팝업 창으로 부터 수정 노티 받은 후 -> 평점 입력 화면 보여주기
    @objc func editNotification(_ notification: Notification) {
        presenter.editNotification()
    }

    /// 팝업 창으로 부터 삭제 노티 받은 후 -> Alert 창 보여주기
    @objc func deleteNotification(_ notification: Notification) {
        presenter.deleteNotification()
    }

    /// 리뷰 삭제 노티 받은 후 -> 해당 리뷰 삭제하기
    @objc func deleteReviewNotification(_ notification: Notification) {
        presenter.deleteReviewNotification()
    }
}

// MARK: - UIPopoverPresentationControllerDelegate
extension DetailViewController: UIPopoverPresentationControllerDelegate {

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }

    func popoverPresentationControllerDidDismissPopover(
        _ popoverPresentationController: UIPopoverPresentationController
    ) {

    }

    func popoverPresentationControllerShouldDismissPopover(
        _ popoverPresentationController: UIPopoverPresentationController
    ) -> Bool {
        return true
    }
}
