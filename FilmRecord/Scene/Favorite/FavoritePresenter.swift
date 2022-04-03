//
//  FavoritePresenter.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/03.
//  좋아하는 영화 Presenter

import Foundation
import UIKit

protocol FavoriteProtocol: AnyObject {
    func setupNavigationBar()
    func setupNoti()
    func setupView()
    func pushToMenuViewController()
    func reloadCollectionView()
    func pushToDetailViewController(review: Review)
}

final class FavoritePresenter: NSObject {
    private weak var viewController: FavoriteProtocol?
    private let userDefaultsManager: UserDefaultsManagerProtocol

    private var reviews: [Review] = []

    init(
        viewController: FavoriteProtocol?,
        userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager()
    ) {
        self.viewController = viewController
        self.userDefaultsManager = userDefaultsManager
    }

    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupNoti()
        viewController?.setupView()
    }
    
    func viewWillAppear() {
        reviews = userDefaultsManager.getReviews().filter { $0.favorite }
        viewController?.reloadCollectionView()
    }

    func didTappedLeftBarButton() {
        viewController?.pushToMenuViewController()
    }
}

// MARK: - UICollectionView
extension FavoritePresenter: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

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
            withReuseIdentifier: FavoriteCollectionViewCell.identifier,
            for: indexPath
        ) as? FavoriteCollectionViewCell else { return UICollectionViewCell() }

        let review = reviews[indexPath.item]
        cell.update(review)

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
