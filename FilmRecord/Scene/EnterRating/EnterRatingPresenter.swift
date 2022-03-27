//
//  EnterRatingPresenter.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/26.
//  영화 평점 입력 Presenter

import Foundation

protocol EnterRatingProtocol: AnyObject {
    func setupNavigationBar()
    func setupView(movie: Movie)
    func popViewController()
    func pushToReviewWriteViewController(movie: Movie, rating: Double)
}

final class EnterRatingPresenter: NSObject {
    private weak var viewController: EnterRatingProtocol?

    private var movie: Movie

    init(
        viewController: EnterRatingProtocol,
        movie: Movie
    ) {
        self.viewController = viewController
        self.movie = movie
    }

    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupView(movie: movie)
    }

    func didTappedLeftBarButton() {
        viewController?.popViewController()
    }

    func didTappedRightBarButton(rating: Double) {
        viewController?.pushToReviewWriteViewController(movie: movie, rating: rating)
    }
}
