//
//  MockEnterRatingViewController.swift
//  FilmRecordTests
//
//  Created by 김민지 on 2022/04/25.
//  EnterRatingViewController Mock

import XCTest
@testable import FilmRecord

final class MockEnterRatingViewController: EnterRatingProtocol {
    var isCalledSetupAppearance = false
    var isCalledSetupNavigationBar = false
    var isCalledSetupView = false
    var isCalledApplyFont = false
    var isCalledPopViewController = false
    var isCalledPushToReviewWriteViewController = false

    func setupAppearance() {
        isCalledSetupAppearance = true
    }

    func setupNavigationBar() {
        isCalledSetupNavigationBar = true
    }

    func setupView(movie: Movie, review: Review, isEditing: Bool) {
        isCalledSetupView = true
    }

    func applyFont() {
        isCalledApplyFont = true
    }

    func popViewController() {
        isCalledPopViewController = true
    }

    func pushToReviewWriteViewController(movie: Movie, rating: Double, review: Review, isEditing: Bool) {
        isCalledPushToReviewWriteViewController = true
    }
}
