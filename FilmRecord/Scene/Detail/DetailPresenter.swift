//
//  DetailPresenter.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/29.
//  리뷰 상세 Presenter

import Foundation

protocol DetailProtocol: AnyObject {
    func setupNavigationBar()
    func setupView(review: Review)
    func popViewController()
    func showPopUp()
}

final class DetailPresenter: NSObject {
    private weak var viewController: DetailProtocol?

    private var review: Review

    init(
        viewController: DetailProtocol?,
        review: Review
    ) {
        self.viewController = viewController
        self.review = review
    }

    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupView(review: review)
    }

    func didTappedLeftBarButton() {
        viewController?.popViewController()
    }

    func didTappedRightBarButton() {
        viewController?.showPopUp()
    }
}
