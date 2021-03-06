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

    /// 시간 포맷(yyyy년 M월 d일 EEEE)
    private lazy var longFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 d일 EEEE"
        formatter.locale = Locale(identifier: "ko_KR")

        return formatter
    }()

    /// 시간 포맷(yy.MM.dd)
    private lazy var shortFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        formatter.locale = Locale(identifier: "ko_KR")

        return formatter
    }()

    /// 하트 버튼
    var heartButton: UIButton = {
        let button = UIButton()
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.8
        button.layer.shadowRadius = 2.0
        button.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)

        return button
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

    /// 영화 제목
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.sizeToFit()

        return label
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

    /// Cell UI Update
    func update(_ review: Review) {
        setupView()
        applyFont()

        thumbnailImageView.kf.setImage(with: review.movie.imageURL, placeholder: UIImage(named: "thumbnail"))
        titleLabel.text = review.movie.title.htmlEscaped
        ratingView.rating = review.rating

        if review.favorite {
            heartButton.setImage(UIImage(
                systemName: "heart.fill",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .semibold, scale: .default)
            ), for: .normal)
            heartButton.tintColor = .systemPink
        } else {
            heartButton.setImage(UIImage(
                systemName: "heart",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .semibold, scale: .default)
            ), for: .normal)
            heartButton.tintColor = .white
        }
    }
}

private extension HomeCollectionViewCell {
    /// 뷰 구성
    func setupView() {

        [thumbnailImageView, ratingView, titleLabel, heartButton].forEach {
            addSubview($0)
        }

        thumbnailImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(snp.width).multipliedBy(1.3)
        }

        heartButton.snp.makeConstraints {
            $0.top.equalTo(thumbnailImageView.snp.top)
            $0.trailing.equalTo(thumbnailImageView.snp.trailing)
            $0.width.equalTo(snp.width).multipliedBy(0.3)
            $0.height.equalTo(heartButton.snp.width)
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

    /// 폰트 적용
    func applyFont() {
        let font = FontManager.getFont()

        titleLabel.font = font.mediumFont
    }
}
