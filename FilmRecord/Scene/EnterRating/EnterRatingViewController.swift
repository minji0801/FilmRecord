//
//  EnterRatingViewController.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/26.
//  영화 평점 입력 화면

import Cosmos
import Kingfisher
import SnapKit
import UIKit

final class EnterRatingViewController: UIViewController {
    private var presenter: EnterRatingPresenter!
    private let inset: CGFloat = 16.0
    private let cornerRadius: CGFloat = 12.0

    init(movie: Movie, review: Review, isEditing: Bool) {
        super.init(nibName: nil, bundle: nil)
        presenter = EnterRatingPresenter(
            viewController: self,
            movie: movie,
            review: review,
            isEditing: isEditing
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Left Bar Button:  뒤로가기 버튼
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
        stackView.alignment = .center
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

    /// 영화 썸네일 이미지
    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    /// 영화 제목
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 3

        return label
    }()

    /// 사용자 평점 뷰
    private lazy var ratingView: CosmosView = {
        let cosmosView = CosmosView()
        cosmosView.settings.starSize = 35
        cosmosView.settings.starMargin = 5
        cosmosView.settings.fillMode = .full

        cosmosView.rating = 3

        cosmosView.settings.filledImage = UIImage(named: "star.fill")
        cosmosView.settings.emptyImage = UIImage(named: "star")

        return cosmosView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
}

// MARK: - ReviewWriteProtocol Function
extension EnterRatingViewController: EnterRatingProtocol {
    /// 화면 Appearance 설정
    func setupAppearance() {
        DarkModeManager.applyAppearance(mode: DarkModeManager.getAppearance(), viewController: self)
    }

    /// 네비게이션 바 구성
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    /// 뷰 구성
    func setupView(movie: Movie, review: Review, isEditing: Bool) {
        view.backgroundColor = .secondarySystemBackground

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(didTappedLeftBarButton))
        view.addGestureRecognizer(swipeLeft)

        thumbnailImageView.kf.setImage(with: movie.imageURL, placeholder: UIImage(named: "thumbnail"))
        titleLabel.text = movie.title.htmlEscaped
        if isEditing { ratingView.rating = review.rating }

        let pubDateStackView = LabelHorizontalStackView(title: "YEAR.", content: movie.pubDate)
        let directorStackView = LabelHorizontalStackView(title: "DIRECTOR.", content: movie.director.withComma)
        let actorStackView = LabelHorizontalStackView(title: "ACTOR.", content: movie.actor.withComma)
        let infoStackView = ThreeRowVerticalStackView(
            row1: pubDateStackView,
            row2: directorStackView,
            row3: actorStackView
        )

        view.addSubview(verticalStactView)

        [thumbnailImageView, titleLabel, ratingView, infoStackView].forEach {
            verticalStactView.addArrangedSubview($0)
        }

        let spacing: CGFloat = 20.0

        verticalStactView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(spacing)
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }

        thumbnailImageView.snp.makeConstraints {
            $0.width.equalTo(150)
            $0.height.equalTo(thumbnailImageView.snp.width).multipliedBy(1.3)
        }
    }

    /// 폰트 적용
    func applyFont() {
        let font = FontManager.getFont()

        titleLabel.font = font.extraLargeFont
    }

    /// 현재 뷰 pop
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }

    /// 리뷰 작성 화면 push
    func pushToReviewWriteViewController(movie: Movie, rating: Double, review: Review, isEditing: Bool) {
        let reviewWriteViewController = ReviewWriteViewController(
            movie: movie,
            rating: rating,
            review: review,
            isEditing: isEditing
        )
        navigationController?.pushViewController(reviewWriteViewController, animated: true)
    }
}

// MARK: - @objc Function
extension EnterRatingViewController {
    /// 뒤로 가기 버튼 클릭 -> 현재 뷰 pop
    @objc func didTappedLeftBarButton() {
        presenter.didTappedLeftBarButton()
    }

    /// 체크 버튼 클릭 -> 리뷰 작성 화면 push
    @objc func didTappedRightBarButton() {
        presenter.didTappedRightBarButton(rating: ratingView.rating)
    }
}
