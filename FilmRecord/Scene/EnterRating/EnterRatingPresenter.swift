//
//  EnterRatingPresenter.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/26.
//  영화 평점 입력 Presenter

import Foundation

protocol EnterRatingProtocol: AnyObject {
    func setupAppearance()
    func setupNavigationBar()
    func setupView(movie: Movie, review: Review, isEditing: Bool)

    func applyFont()
    func popViewController()
    func pushToReviewWriteViewController(movie: Movie, rating: Double, review: Review, isEditing: Bool)
}

final class EnterRatingPresenter: NSObject {
    private weak var viewController: EnterRatingProtocol?

    private var movie: Movie
    private var review: Review
    private var isEditing: Bool

    init(
        viewController: EnterRatingProtocol,
        movie: Movie,
        review: Review,
        isEditing: Bool
    ) {
        self.viewController = viewController
        self.movie = movie
        self.review = review
        self.isEditing = isEditing
    }

    func viewDidLoad() {
        viewController?.setupAppearance()
        viewController?.setupNavigationBar()
        viewController?.setupView(movie: movie, review: review, isEditing: isEditing)
        viewController?.applyFont()
    }

    func didTappedLeftBarButton() {
        viewController?.popViewController()
    }

    func didTappedRightBarButton(rating: Double) {
        viewController?.pushToReviewWriteViewController(
            movie: movie,
            rating: rating,
            review: review,
            isEditing: isEditing
        )
    }
}
