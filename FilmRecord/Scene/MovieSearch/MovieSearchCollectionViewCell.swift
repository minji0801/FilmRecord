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
        imageView.backgroundColor = .secondarySystemBackground

        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = FontManager().mediumFont()
        label.numberOfLines = 3

        return label
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = FontManager().smallFont()

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
        layer.cornerRadius = 12.0

        layer.shadowColor = UIColor.systemGray.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 12.0

        backgroundColor = .systemBackground

        self.addSubview(verticalStactView)

        [thumbnailImageView, dateLabel, titleLabel].forEach {
            verticalStactView.addArrangedSubview($0)
        }

        verticalStactView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10.0)
            $0.top.bottom.equalToSuperview().inset(10.0)
        }

        dateLabel.snp.makeConstraints {
            $0.height.equalTo(verticalStactView.snp.width).multipliedBy(0.1)
        }

        thumbnailImageView.snp.makeConstraints {
            $0.height.equalTo(verticalStactView.snp.width).multipliedBy(1.4)
        }
    }
}
