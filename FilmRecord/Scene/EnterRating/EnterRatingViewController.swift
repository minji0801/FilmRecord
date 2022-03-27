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
    private lazy var presenter = EnterRatingPresenter(viewController: self)

    private lazy var leftBarButtonItem: UIBarButtonItem = {
        let leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .plain,
            target: self,
            action: #selector(didTappedRightBarButton)
        )

        return leftBarButtonItem
    }()

    private lazy var rightBarButtonItem: UIBarButtonItem = {
        let rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrow.right"),
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
        stackView.spacing = 16.0

        return stackView
    }()

    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5.0
        let url = URL(string: "https://movie-phinf.pstatic.net/20170110_166/1484038104926uPjpU_JPEG/movie_image.jpg")
        imageView.kf.setImage(with: url)

        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17.0)
        label.textAlignment = .center
        label.numberOfLines = 3
        label.text = "짱구는 못말려 극장판: 폭풍수면! 꿈꾸는 세계 대돌격"

        return label
    }()

    private lazy var ratingView: CosmosView = {
        let cosmosView = CosmosView()
        cosmosView.settings.starSize = 30
        cosmosView.settings.starMargin = 8
        cosmosView.settings.fillMode = .full

        cosmosView.rating = 3

        cosmosView.settings.filledImage = UIImage(systemName: "heart.fill")
        cosmosView.settings.emptyImage = UIImage(systemName: "heart")

        cosmosView.settings.filledColor = UIColor.red
        cosmosView.settings.emptyBorderColor = UIColor.red
        cosmosView.settings.filledBorderColor = UIColor.red

        cosmosView.didFinishTouchingCosmos = { rating in
            print(rating)
            // rating : 사용자가 선택한 평점 (1.0, 2.0, 3.0, 4.0, 5.0)
        }

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

    func setupView() {
        let pubDateStackView = LabelHorizontalStackView(title: "개봉", content: "2016")
        let directorStackView = LabelHorizontalStackView(title: "감독", content: "타카하시 와타루")
        let actorStackView = LabelHorizontalStackView(title: "배우", content: "야자마 아키코, 나라하지 미키, 후지와라 케이지")
        let infoStackView = MovieInfoVerticalStackView(
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
            $0.centerY.equalToSuperview()
        }

        thumbnailImageView.snp.makeConstraints {
//            $0.height.equalTo(verticalStactView.snp.width).multipliedBy(1.5)
            $0.width.equalTo(100)
            $0.height.equalTo(150)
        }    }
}

// MARK: - @objc Function
extension EnterRatingViewController {

    /// Left  bar button was tapped.
    @objc func didTappedLeftBarButton() {
//        
    }

    /// Right bar button was tapped.
    @objc func didTappedRightBarButton() {
        presenter.didTappedRightBarButton()
    }
}
