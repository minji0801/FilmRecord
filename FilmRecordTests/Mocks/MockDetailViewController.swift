//
//  MockDetailViewController.swift
//  FilmRecordTests
//
//  Created by 김민지 on 2022/04/24.
//  DetailViewController Mock

import XCTest
@testable import FilmRecord

final class MockDetailViewController: DetailProtocol {
    var isCalledSetupAppearance = false
    var isCalledSetupNavigationBar = false
    var isCalledSetupNoti = false
    var isCalledSetupGesture = false
    var isCalledSetupView = false
    var isCalledApplyFont = false
    var isCalledPopViewController = false
    var isCalledPushToEnterRatingViewController = false
    var isCalledShowDeleteAlert = false
    var isCalledUpdateRightBarLikeButton = false
    var isCalledShowToast = false

    func setupAppearance() {
        isCalledSetupAppearance = true
    }

    func setupNavigationBar() {
        isCalledSetupNavigationBar = true
    }

    func setupNoti() {
        isCalledSetupNoti = true
    }

    func setupGesture() {
        isCalledSetupGesture = true
    }

    func setupView(review: Review) {
        isCalledSetupView = true
    }

    func applyFont() {
        isCalledApplyFont = true
    }

    func popViewController() {
        isCalledPopViewController = true
    }

    func pushToEnterRatingViewController() {
        isCalledPushToEnterRatingViewController = true
    }

    func showDeleteAlert() {
        isCalledShowDeleteAlert = true
    }

    func updateRightBarLikeButton(review: Review) {
        isCalledUpdateRightBarLikeButton = true
    }

    func showToast(_ show: Bool) {
        isCalledShowToast = true
    }
}
