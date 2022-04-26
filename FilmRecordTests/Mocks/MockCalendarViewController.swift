//
//  MockCalendarViewController.swift
//  FilmRecordTests
//
//  Created by 김민지 on 2022/04/26.
//

import XCTest
@testable import FilmRecord

final class MockCalendarViewController: CalendarProtocol {
    var isCalledSetupAppearance = false
    var isCalledSetupNavigationBar = false
    var isCalledSetupNoti = false
    var isCalledSetupView = false
    var isCalledApplyFont = false
    var isCalledPushToMenuViewController = false
    var isCalledMoveToToday = false
    var isCalledReloadTableView = false
    var isCalledPushToDetailViewController = false

    func setupAppearance() {
        isCalledSetupAppearance = true
    }

    func setupNavigationBar() {
        isCalledSetupNavigationBar = true
    }

    func setupNoti() {
        isCalledSetupNoti = true
    }

    func setupView() {
        isCalledSetupView = true
    }

    func applyFont() {
        isCalledApplyFont = true
    }

    func pushToMenuViewController() {
        isCalledPushToMenuViewController = true
    }

    func moveToToday() {
        isCalledMoveToToday = true
    }

    func reloadTableView() {
        isCalledReloadTableView = true
    }

    func pushToDetailViewController(review: Review) {
        isCalledPushToDetailViewController = true
    }
}

