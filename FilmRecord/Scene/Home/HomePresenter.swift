//
//  HomePresenter.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/25.
//  홈 Presenter

import Foundation
import UIKit

protocol HomeProtocol: AnyObject {
    func setupNavigationBar()
    func setupView()
    func pushSearchMovieViewController()
    func reloadCollectionView()
}

final class HomePresenter: NSObject {
    private let viewController: HomeProtocol?
    private let userDefaultsManager: UserDefaultsManagerProtocol

    private var reviews: [Review] = []

    init(
        viewController: HomeProtocol,
        userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager()
    ) {
        self.viewController = viewController
        self.userDefaultsManager = userDefaultsManager
    }

    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupView()
    }

    func viewWillAppear() {
        reviews = userDefaultsManager.getReviews()
        print(reviews)
        viewController?.reloadCollectionView()
    }

    func didTappedRightBarButton() {
        viewController?.pushSearchMovieViewController()
    }
}

// MARK: - UICollectionView
extension HomePresenter: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviews.count
    }

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

        return cell
    }

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

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        let inset: CGFloat = 16.0
        return UIEdgeInsets(top: inset, left: inset, bottom: 0.0, right: inset)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: 작성한 리뷰 보여주기
    }
}
