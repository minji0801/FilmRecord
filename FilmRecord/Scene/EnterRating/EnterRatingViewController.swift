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

    init(movie: Movie) {
        super.init(nibName: nil, bundle: nil)
        presenter = EnterRatingPresenter(viewController: self, movie: movie)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
        stackView.alignment = .center
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

    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = FontManager().extraLargeFont()
        label.textAlignment = .center
        label.numberOfLines = 3

        return label
    }()

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
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    func setupView(movie: Movie) {
        view.backgroundColor = .secondarySystemBackground

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(didTappedLeftBarButton))
        view.addGestureRecognizer(swipeLeft)

        thumbnailImageView.kf.setImage(with: movie.imageURL)
        titleLabel.text = movie.title.htmlEscaped

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
//            $0.centerY.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(spacing)
        }

        thumbnailImageView.snp.makeConstraints { $0.width.equalTo(150) }
    }

    func popViewController() {
        navigationController?.popViewController(animated: true)
    }

    func pushToReviewWriteViewController(movie: Movie, rating: Double) {
        let reviewWriteViewController = ReviewWriteViewController(movie: movie, rating: rating)
        navigationController?.pushViewController(reviewWriteViewController, animated: true)
    }
}

// MARK: - @objc Function
extension EnterRatingViewController {

    /// Left  bar button was tapped.
    @objc func didTappedLeftBarButton() {
        presenter.didTappedLeftBarButton()
    }

    /// Right bar button was tapped.
    @objc func didTappedRightBarButton() {
        presenter.didTappedRightBarButton(rating: ratingView.rating)
    }
}
