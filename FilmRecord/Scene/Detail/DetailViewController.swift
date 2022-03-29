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

    init(review: Review) {
        super.init(nibName: nil, bundle: nil)
        presenter = DetailPresenter(viewController: self, review: review)
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
            image: UIImage(systemName: "ellipsis"),
            style: .plain,
            target: self,
            action: #selector(didTappedRightBarButton)
        )

        return rightBarButtonItem
    }()

    private lazy var topVerticalStactView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 16.0

        return stackView
    }()

    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20.0)
        label.textAlignment = .center
        label.numberOfLines = 3

        return label
    }()

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

    private lazy var bottomVerticalStactView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 16.0

        return stackView
    }()

    private lazy var reviewTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .label
        textView.font = .systemFont(ofSize: 14.0, weight: .regular)

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
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    func setupView(review: Review) {
        view.backgroundColor = .systemBackground

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(didTappedLeftBarButton))
        view.addGestureRecognizer(swipeLeft)

        navigationItem.title = review.date

        thumbnailImageView.kf.setImage(with: review.movie.imageURL)
        titleLabel.text = review.movie.title.htmlEscaped
        ratingView.rating = review.rating

        let pubDateStackView = LabelHorizontalStackView(title: "YEAR.", content: review.movie.pubDate)
        let directorStackView = LabelHorizontalStackView(title: "DIRECTOR.", content: review.movie.director.withComma)
        let actorStackView = LabelHorizontalStackView(title: "ACTOR.", content: review.movie.actor.withComma)
        let infoStackView = MovieInfoVerticalStackView(
            row1: pubDateStackView,
            row2: directorStackView,
            row3: actorStackView
        )

        let placeStackView = LabelHorizontalStackView(title: "WHERE.", content: review.place)
        let withStackView = LabelHorizontalStackView(title: "WITH.", content: review.with)

        reviewTextView.text = review.review

        [topVerticalStactView, infoStackView, bottomVerticalStactView, reviewTextView].forEach {
            view.addSubview($0)
        }

        [thumbnailImageView, titleLabel, ratingView].forEach {
            topVerticalStactView.addArrangedSubview($0)
        }

        [infoStackView, placeStackView, withStackView].forEach {
            bottomVerticalStactView.addArrangedSubview($0)
        }

        let spacing: CGFloat = 20.0

        topVerticalStactView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(spacing)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(spacing)
        }

        bottomVerticalStactView.snp.makeConstraints {
            $0.leading.equalTo(topVerticalStactView.snp.leading)
            $0.trailing.equalTo(topVerticalStactView.snp.trailing)
            $0.top.equalTo(topVerticalStactView.snp.bottom).offset(spacing)
        }

        thumbnailImageView.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(topVerticalStactView.snp.width).multipliedBy(0.4)
        }

        reviewTextView.snp.makeConstraints {
            $0.leading.equalTo(bottomVerticalStactView.snp.leading)
            $0.trailing.equalTo(bottomVerticalStactView.snp.trailing)
            $0.top.equalTo(bottomVerticalStactView.snp.bottom).offset(spacing)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(spacing)
        }
    }

    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - @objc Function
extension DetailViewController {

    @objc func didTappedLeftBarButton() {
        presenter.didTappedLeftBarButton()
    }

    @objc func didTappedRightBarButton() {
        presenter.didTappedRightBarButton()
    }
}
