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

    private lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 d일 EEEE"
        formatter.locale = Locale(identifier: "ko-KR")

        return formatter
    }()

    private lazy var verticalStactView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 7.0

        return stackView
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12.0)

        return label
    }()

    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12.0)
        label.numberOfLines = 3
//        label.backgroundColor = .secondarySystemBackground

        return label
    }()

    private lazy var ratingView: CosmosView = {
        let cosmosView = CosmosView()
        cosmosView.settings.starSize = 15
        cosmosView.settings.starMargin = 1
        cosmosView.settings.fillMode = .full

        cosmosView.settings.filledImage = UIImage(named: "heart_fill")
        cosmosView.settings.emptyImage = UIImage(named: "heart")

        return cosmosView
    }()

    func update(_ review: Review) {
        setupView()

        guard let date = formatter.date(from: review.date) else { return }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        dateLabel.text = dateFormatter.string(from: date)
        thumbnailImageView.kf.setImage(with: review.movie.imageURL, placeholder: UIImage(named: "thumbnail"))
        titleLabel.text = review.movie.title.htmlEscaped
        ratingView.rating = review.rating
    }
}

private extension HomeCollectionViewCell {
    // View 구성
    func setupView() {
        layer.cornerRadius = 12.0
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOpacity = 0.1
//        layer.shadowRadius = 8.0

        backgroundColor = .secondarySystemBackground

        self.addSubview(verticalStactView)

        [dateLabel, thumbnailImageView, ratingView, titleLabel].forEach {
            verticalStactView.addArrangedSubview($0)
        }

        verticalStactView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10.0)
            $0.top.bottom.equalToSuperview().inset(15.0)
//            $0.edges.equalToSuperview()
        }

        dateLabel.snp.makeConstraints {
            $0.height.equalTo(verticalStactView.snp.height).multipliedBy(0.05)
        }

        thumbnailImageView.snp.makeConstraints {
//            $0.width.equalTo(verticalStactView.snp.width).multipliedBy(3/4)
//            $0.height.equalTo(verticalStactView.snp.height).multipliedBy(0.5)
            $0.height.equalTo(verticalStactView.snp.width).multipliedBy(1.4)
        }

        ratingView.snp.makeConstraints {
            $0.height.equalTo(verticalStactView.snp.height).multipliedBy(0.05)
        }
    }
}
