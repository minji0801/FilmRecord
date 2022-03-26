//
//  ReviewWriteViewController.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/26.
//  리뷰 작성 화면

import Cosmos
import Kingfisher
import SnapKit
import UIKit

final class ReviewWriteViewController: UIViewController {
    private lazy var presenter = ReviewWritePresenter(viewController: self)

    private lazy var leftBarButtonItem: UIBarButtonItem = {
        let leftBarButtonItem = UIBarButtonItem()
        leftBarButtonItem.image = UIImage(systemName: "xmark")

        return leftBarButtonItem
    }()

    private lazy var rightBarButtonItem: UIBarButtonItem = {
        let rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "checkmark"),
            style: .plain,
            target: self,
            action: #selector(didTappedRightBarButton)
        )

        return rightBarButtonItem
    }()

    private lazy var verticalStactView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 10.0
//        stackView.backgroundColor = .secondarySystemBackground

        return stackView
    }()

    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5.0
//        imageView.backgroundColor = .systemYellow
        let url = URL(string: "https://movie-phinf.pstatic.net/20170110_166/1484038104926uPjpU_JPEG/movie_image.jpg")
        imageView.kf.setImage(with: url)

        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17.0, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 3
        label.text = "짱구는 못말려 극장판: 폭풍수면! 꿈꾸는 세계 대돌격"
//        label.backgroundColor = .systemTeal

        return label
    }()

    private lazy var starView: CosmosView = {
        let cosmosView = CosmosView()
        cosmosView.settings.starSize = 30
        cosmosView.settings.starMargin = 8
        cosmosView.settings.fillMode = .full

        cosmosView.rating = 3

        cosmosView.settings.filledImage = UIImage(systemName: "heart.fill")
        cosmosView.settings.emptyImage = UIImage(systemName: "heart")

//        cosmosView.settings.filledColor = UIColor.red
//        cosmosView.settings.emptyBorderColor = UIColor.red
//        cosmosView.settings.filledBorderColor = UIColor.red

        cosmosView.didFinishTouchingCosmos = { rating in
            print(rating)
            // rating : 사용자가 선택한 평점 (1.0, 2.0, 3.0, 4.0, 5.0)
        }

        return cosmosView
    }()

    private lazy var separatorLine: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.systemGray2.cgColor
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
        print(starView.rating)
    }
}

extension UITextField {
  func setLeftView(image: UIImage) {
    let iconView = UIImageView(frame: CGRect(x: 10, y: 10, width: 25, height: 25)) // set your Own size
    iconView.image = image
    let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 45))
    iconContainerView.addSubview(iconView)
    leftView = iconContainerView
    leftViewMode = .always
    self.tintColor = .lightGray
  }
}

// MARK: - ReviewWriteProtocol Function
extension ReviewWriteViewController: ReviewWriteProtocol {
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    func setupView() {
        let pubDateStackView = MovieInfoHorizontalStackView(title: "개봉", content: "2016")
        let directorStackView = MovieInfoHorizontalStackView(title: "감독", content: "타카하시 와타루")
        let actorStackView = MovieInfoHorizontalStackView(title: "배우", content: "야자마 아키코, 나라하지 미키, 후지와라 케이지")
        let infoStackView = MovieInfoVerticalStackView(
            row1: pubDateStackView,
            row2: directorStackView,
            row3: actorStackView
        )

        [verticalStactView, infoStackView, separatorLine].forEach {
            view.addSubview($0)
        }

        [thumbnailImageView, titleLabel, starView].forEach {
            verticalStactView.addArrangedSubview($0)
        }

        let spacing: CGFloat = 20.0

        verticalStactView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(spacing)
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }

        thumbnailImageView.snp.makeConstraints {
//            $0.height.equalTo(verticalStactView.snp.width).multipliedBy(1.5)
            $0.width.equalTo(100)
            $0.height.equalTo(150)
        }

        infoStackView.snp.makeConstraints {
            $0.leading.equalTo(verticalStactView.snp.leading)
            $0.trailing.equalTo(verticalStactView.snp.trailing)
            $0.top.equalTo(verticalStactView.snp.bottom).offset(spacing)
        }

        separatorLine.snp.makeConstraints {
            $0.leading.equalTo(infoStackView.snp.leading)
            $0.trailing.equalTo(infoStackView.snp.trailing)
            $0.top.equalTo(infoStackView.snp.bottom).offset(spacing)
            $0.height.equalTo(1)
        }
    }
}

// MARK: - @objc Function
extension ReviewWriteViewController {

    /// Right bar button was tapped.
    @objc func didTappedRightBarButton() {
        presenter.didTappedRightBarButton()
    }
}
