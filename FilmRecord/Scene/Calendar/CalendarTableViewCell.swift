//
//  CalendarTableViewCell.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/06.
//  캘린더 화면에서 보여줄 리뷰 셀

import Cosmos
import Kingfisher
import SnapKit
import UIKit

final class CalendarTableViewCell: UITableViewCell {
    static let identifier = "CalendarTableViewCell"

    /// 영화 썸네일 이미지
    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .secondarySystemBackground

        return imageView
    }()

    /// 영화 제목 라벨
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2

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

    /// Cell UI 업데이트
    func update(_ review: Review) {
        setupView()
        applyFont()

        thumbnailImageView.kf.setImage(with: review.movie.imageURL, placeholder: UIImage(named: "thumbnail"))
        titleLabel.text = review.movie.title.htmlEscaped
        ratingView.rating = review.rating
    }
}

private extension CalendarTableViewCell {
    /// 뷰 구성
    func setupView() {
        backgroundColor = .secondarySystemBackground
        selectionStyle = .none

        [thumbnailImageView, titleLabel, ratingView].forEach {
            addSubview($0)
        }

        /// 영화 썸네일 Constraints
        thumbnailImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20.0)
            $0.top.bottom.equalToSuperview().inset(5.0)
            $0.width.equalTo(thumbnailImageView.snp.height).multipliedBy(2.0/3.0)
        }

        /// 영화 제목 라벨 Constraints
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(10.0)
            $0.top.equalTo(thumbnailImageView.snp.top)
            $0.bottom.equalTo(thumbnailImageView.snp.bottom)
        }

        ratingView.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(10.0)
            $0.trailing.centerY.equalToSuperview()
            $0.width.equalTo(90)
        }
    }

    /// 폰트 적용
    func applyFont() {
        let font = FontManager.getFont()

        titleLabel.font = font.largeFont
    }
}
