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

    /// 세로 스택 뷰: 영화 썸네일, 사용자 평점, 영화 제목
    private lazy var verticalStactView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 7.0

        return stackView
    }()

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
        label.font = FontManager().smallFont()
        label.numberOfLines = 3

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
        layer.cornerRadius = 12.0

        layer.shadowColor = UIColor.systemGray.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 12.0

        backgroundColor = .systemBackground

        [verticalStactView].forEach {
            self.addSubview($0)
        }

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
