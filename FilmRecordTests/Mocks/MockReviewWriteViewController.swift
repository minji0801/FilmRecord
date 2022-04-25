//
//  MockReviewWriteViewController.swift
//  FilmRecordTests
//
//  Created by 김민지 on 2022/04/25.
//  ReviewWriteViewController Mock

import XCTest
@testable import FilmRecord

final class MockReviewWriteViewController: ReviewWriteProtocol {
    var isCalledSetupAppearance = false
    var isCalledSetupNavigationBar = false
    var isCalledSetupNoti = false
    var isCalledSetupView = false
    var isCalledApplyFont = false
    var isCalledShowDatePickerAlertViewController = false
    var isCalledKeyboardDown = false
    var isCalledPopViewController = false
    var isCalledPopToRootViewController = false

    func setupAppearance() {
        isCalledSetupAppearance = true
    }

    func setupNavigationBar() {
        isCalledSetupNavigationBar = true
    }

    func setupNoti() {
        isCalledSetupNoti = true
    }

    func setupView(review: Review, isEditing: Bool) {
        isCalledSetupView = true
    }

    func applyFont() {
        isCalledApplyFont = true
    }

    func showDatePickerAlertViewController() {
        isCalledShowDatePickerAlertViewController = true
    }

    func keyboardDown() {
        isCalledKeyboardDown = true
    }

    func popViewController() {
        isCalledPopViewController = true
    }

    func popToRootViewController() {
        isCalledPopToRootViewController = true
    }
}
