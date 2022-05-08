//
//  HomePresenter.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/25.
//  홈 Presenter

import Foundation
import Toast
import UIKit

protocol HomeProtocol: AnyObject {
    func setupAppearance()
    func setupNavigationBar()
    func setupNoti()
    func setupView()

    func applyFont()
    func pushToMenuViewController()
    func pushToSearchMovieViewController()
    func reloadCollectionView()
    func pushToDetailViewController(review: Review)
    func showToast(_ show: Bool)
}

final class HomePresenter: NSObject {
    private let viewController: HomeProtocol?
    private let userDefaultsManager: UserDefaultsManagerProtocol

    var reviews: [Review] = []
    private var movie: Movie = Movie.EMPTY

    init(
        viewController: HomeProtocol?,
        userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager()
    ) {
        self.viewController = viewController
        self.userDefaultsManager = userDefaultsManager
    }

    func viewDidLoad() {
        viewController?.setupAppearance()
        viewController?.setupNavigationBar()
        viewController?.setupNoti()
        viewController?.setupView()
    }

    func viewWillAppear() {
        reviews = userDefaultsManager.getReviews()
        viewController?.reloadCollectionView()
        viewController?.applyFont()
    }

    func didTappedLeftBarButton() {
        viewController?.pushToMenuViewController()
    }

    func didTappedRightBarButton() {
        viewController?.pushToSearchMovieViewController()
    }

    @objc func didTappedLikeButton(_ sender: UIButton) {
        if reviews[sender.tag].favorite {
            reviews[sender.tag].favorite = false
            viewController?.showToast(false)
        } else {
            reviews[sender.tag].favorite = true
            viewController?.showToast(true)
        }
        userDefaultsManager.overwriteReview(reviews)
        viewController?.reloadCollectionView()
    }
}

// MARK: - UICollectionView
extension HomePresenter: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    /// Cell 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviews.count
    }

    /// Cell 구성
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HomeCollectionViewCell.identifier,
            for: indexPath
        ) as? HomeCollectionViewCell else { return UICollectionViewCell() }

        let review = reviews[indexPath.item]
        cell.update(review)

        cell.heartButton.tag = indexPath.row
        cell.heartButton.addTarget(self, action: #selector(didTappedLikeButton(_:)), for: .touchUpInside)

        return cell
    }

    /// Cell 사이즈
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let inset: CGFloat = 16.0
        let spacing: CGFloat = 10.0
        let width: CGFloat = (collectionView.frame.width - (inset * 2) - (spacing * 2)) / 3
        return CGSize(width: width, height: width * 2)
    }

    /// CollectionView Inset 설정
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        let inset: CGFloat = 16.0
        return UIEdgeInsets(top: inset, left: inset, bottom: 0.0, right: inset)
    }

    /// Cell 클릭: 해당 영화의 리뷰 정보 보여주기
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let review = reviews[indexPath.row]
        viewController?.pushToDetailViewController(review: review)
    }
}
