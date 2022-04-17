//
//  MovieSearchCollectionViewCell.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/25.
//  영화 검색 CollectionView Cell

import Kingfisher
import SnapKit
import UIKit

final class MovieSearchCollectionViewCell: UICollectionViewCell {
    static let identifier = "MovieSearchCollectionViewCell"

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
        label.font = FontManager().mediumFont()
        label.numberOfLines = 3

        return label
    }()

    /// 개봉년도
    private lazy var pubDateLabel: UILabel = {
        let label = UILabel()
        label.font = FontManager().smallFont()
        label.textAlignment = .left

        return label
    }()

    /// Cell UI Update
    func update(movie: Movie) {
        setupView()

        thumbnailImageView.kf.setImage(with: movie.imageURL, placeholder: UIImage(named: "thumbnail"))
        titleLabel.text = movie.title.htmlEscaped
        pubDateLabel.text = movie.pubDate
    }
}

private extension MovieSearchCollectionViewCell {
    /// 뷰 구성
    func setupView() {
        backgroundColor = .systemBackground

        let stackView = UIStackView(
            arrangedSubviews: [thumbnailImageView, pubDateLabel, titleLabel]
        )
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8.0

        addSubview(stackView)

        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        pubDateLabel.snp.makeConstraints {
            $0.height.equalTo(stackView.snp.width).multipliedBy(0.1)
        }

        thumbnailImageView.snp.makeConstraints {
            $0.height.equalTo(stackView.snp.width).multipliedBy(1.3)
        }
    }
}
