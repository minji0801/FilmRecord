//
//  DetailPresenter.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/29.
//  리뷰 상세 Presenter

import Foundation

protocol DetailProtocol: AnyObject {
    func setupNavigationBar()
    func setupNoti()
    func setupView(review: Review)
    func popViewController()
    func pushToEnterRatingViewController()
    func showDeleteAlert()
}

final class DetailPresenter: NSObject {
    private weak var viewController: DetailProtocol?
    private let userDefaultsManager: UserDefaultsManagerProtocol

    var review: Review

    init(
        viewController: DetailProtocol?,
        userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager(),
        review: Review
    ) {
        self.viewController = viewController
        self.userDefaultsManager = userDefaultsManager
        self.review = review
    }

    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupNoti()
        viewController?.setupView(review: review)
    }

    func didTappedLeftBarButton() {
        viewController?.popViewController()
    }

    func editNotification() {
        viewController?.pushToEnterRatingViewController()
    }

    func deleteNotification() {
        viewController?.showDeleteAlert()
    }

    func deleteReviewNotification() {
        let id = review.id
        userDefaultsManager.deleteReview(id: id)
        viewController?.popViewController()
    }
}
