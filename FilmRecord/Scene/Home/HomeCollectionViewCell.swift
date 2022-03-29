//
//  HomeCollectionViewCell.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/28.
//  홈 CollectionView Cell

import Cosmos
import Kingfisher
import SnapKit
import UIKit

final class HomeCollectionViewCell: UICollectionViewCell {
    static let identifier = "HomeCollectionViewCell"

    private lazy var verticalStactView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 7.0

        return stackView
    }()

    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12.0

        return imageView
    }()

    private lazy var dottedLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray

        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12.0)
        label.numberOfLines = 3

        return label
    }()

    private lazy var ratingView: CosmosView = {
        let cosmosView = CosmosView()
        cosmosView.settings.starSize = 15
        cosmosView.settings.starMargin = 0
        cosmosView.settings.fillMode = .full

        cosmosView.settings.filledImage = UIImage(named: "heart_fill")
        cosmosView.settings.emptyImage = UIImage(named: "heart")

        return cosmosView
    }()

    func update(_ review: Review) {
        setupView()

        thumbnailImageView.kf.setImage(with: review.movie.imageURL, placeholder: UIImage(named: "thumbnail"))
        titleLabel.text = review.movie.title.htmlEscaped
        ratingView.rating = review.rating
    }
}

private extension HomeCollectionViewCell {
    // View 구성
    func setupView() {
        layer.cornerRadius = 12.0

        layer.shadowColor = UIColor.systemGray.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 12.0

        backgroundColor = .systemBackground

        self.addSubview(verticalStactView)

        [thumbnailImageView, ratingView, titleLabel].forEach {
            verticalStactView.addArrangedSubview($0)
        }

        verticalStactView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10.0)
            $0.top.bottom.equalToSuperview().inset(10.0)
        }

        thumbnailImageView.snp.makeConstraints {
            $0.height.equalTo(verticalStactView.snp.width).multipliedBy(1.4)
        }

        ratingView.snp.makeConstraints {
            $0.height.equalTo(verticalStactView.snp.height).multipliedBy(0.05)
        }
    }
}
