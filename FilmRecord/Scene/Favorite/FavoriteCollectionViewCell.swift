//
//  FavoriteCollectionViewCell.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/03.
//  좋아하는 영화 셀

import Cosmos
import Kingfisher
import SnapKit
import UIKit

final class FavoriteCollectionViewCell: UICollectionViewCell {
    static let identifier = "FavoriteCollectionViewCell"

    /// 영화 썸네일 이미지
    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12.0
        imageView.backgroundColor = .secondarySystemBackground

        return imageView
    }()

    /// 사용자 평점 뷰
    private lazy var ratingView: CosmosView = {
        let cosmosView = CosmosView()
        cosmosView.settings.starSize = 15
        cosmosView.settings.starMargin = 0
        cosmosView.settings.fillMode = .full

        cosmosView.settings.filledImage = UIImage(named: "star.fill")
        cosmosView.settings.emptyImage = UIImage(named: "star")

        return cosmosView
    }()

    /// 영화 제목
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = FontManager().mediumFont()
        label.numberOfLines = 3
        label.sizeToFit()

        return label
    }()

    /// Cell UI Update
    func update(_ review: Review) {
        setupView()

        thumbnailImageView.kf.setImage(with: review.movie.imageURL, placeholder: UIImage(named: "thumbnail"))
        titleLabel.text = review.movie.title.htmlEscaped
        ratingView.rating = review.rating
    }
}

private extension FavoriteCollectionViewCell {
    /// 뷰 구성
    func setupView() {
        backgroundColor = .systemBackground

        [thumbnailImageView, ratingView, titleLabel].forEach {
            addSubview($0)
        }

        thumbnailImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(snp.width).multipliedBy(1.3)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(thumbnailImageView.snp.bottom).offset(8.0)
            $0.leading.trailing.equalToSuperview()
        }

        ratingView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8.0)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(snp.width).multipliedBy(0.1)
        }
    }
}
