//
//  ToWatchTableViewCell.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/02.
//  보고 싶은 영화 셀

import Kingfisher
import SnapKit
import UIKit

final class ToWatchTableViewCell: UITableViewCell {
    static let identifier = "ToWatchTableViewCell"

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

    /// 중앙 가로 선
    private lazy var horizontalLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink.withAlphaComponent(0.2)
        view.isHidden = true

        return view
    }()

    /// update Cell UI
    func update(_ watch: Watch) {
        setupView()
        applyFont()

        thumbnailImageView.kf.setImage(with: watch.movie.imageURL, placeholder: UIImage(named: "thumbnail"))
        titleLabel.text = watch.movie.title.htmlEscaped

        if watch.watched {
            // 봤음: 체크마크 & 중앙선 표시, 썸네일 & 제목 흐리게
            accessoryType = .checkmark
            horizontalLineView.isHidden = false
        } else {
            // 안봤음: 체크마크 & 중앙선 표시 안함, 썸네일 & 제목 뚜렷하게
            accessoryType = .none
            horizontalLineView.isHidden = true
        }
    }
}

private extension ToWatchTableViewCell {
    /// View 구성
    func setupView() {
        backgroundColor = .secondarySystemBackground
        tintColor = .systemPink

        [thumbnailImageView, titleLabel, horizontalLineView].forEach { addSubview($0) }

        /// 영화 썸네일 Constraints
        thumbnailImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20.0)
            $0.top.bottom.equalToSuperview().inset(5.0)
            $0.width.equalTo(thumbnailImageView.snp.height).multipliedBy(2.0/3.0)
        }

        /// 영화 제목 라벨 Constraints
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(10.0)
            $0.trailing.equalToSuperview().inset(50.0)
        }

        /// 중앙 가로선 뷰 Constraints
        horizontalLineView.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.trailing.equalTo(titleLabel.snp.trailing)
            $0.centerY.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.top)
            $0.bottom.equalTo(titleLabel.snp.bottom)
        }
    }

    /// 폰트 적용
    func applyFont() {
        let font = FontManager.getFont()

        titleLabel.font = font.largeFont
    }
}
