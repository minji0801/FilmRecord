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

    private lazy var verticalStactView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.distribution = .fill
        stackView.spacing = 5.0

        return stackView
    }()

    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5.0
        imageView.backgroundColor = .secondarySystemBackground

        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .semibold)
        label.textAlignment = .left
        label.numberOfLines = 3

        return label
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .semibold)

        return label
    }()

    func update(movie: Movie) {
        setupView()

        thumbnailImageView.kf.setImage(with: movie.imageURL)
        titleLabel.text = movie.title.htmlEscaped
        dateLabel.text = movie.pubDate
    }
}

private extension MovieSearchCollectionViewCell {
    func setupView() {
        self.addSubview(verticalStactView)

        [thumbnailImageView, titleLabel, dateLabel].forEach {
            verticalStactView.addArrangedSubview($0)
        }

        verticalStactView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        thumbnailImageView.snp.makeConstraints {
            $0.height.equalTo(verticalStactView.snp.width).multipliedBy(1.5)
        }
    }
}
