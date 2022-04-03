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

    /// 좋아요 버튼
    var likeButton: UIButton = {
        let button = UIButton()
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 2.0
        button.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
//        button.backgroundColor = .systemYellow

        return button
    }()

    /// Cell UI Update
    func update(_ review: Review) {
        setupView()

        thumbnailImageView.kf.setImage(with: review.movie.imageURL, placeholder: UIImage(named: "thumbnail"))
        titleLabel.text = review.movie.title.htmlEscaped
        ratingView.rating = review.rating

        if review.favorite {
            likeButton.setImage(UIImage(
                systemName: "heart.fill",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .default)
            ), for: .normal)
            likeButton.tintColor = .systemRed
        } else {
            likeButton.setImage(UIImage(
                systemName: "heart",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .default)
            ), for: .normal)
            likeButton.tintColor = .white
        }
    }
}

private extension HomeCollectionViewCell {
    /// 뷰 구성
    func setupView() {
        layer.cornerRadius = 12.0

        layer.shadowColor = UIColor.systemGray.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 12.0

        backgroundColor = .systemBackground

        [verticalStactView, likeButton].forEach {
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

        likeButton.snp.makeConstraints {
            $0.trailing.equalTo(self.snp.trailing)
            $0.top.equalTo(self.snp.top)
            $0.width.equalTo(self.snp.width).multipliedBy(0.3)
            $0.height.equalTo(likeButton.snp.width)
        }
    }
}
