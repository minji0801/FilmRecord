//
//  MockMenuViewController.swift
//  FilmRecordTests
//
//  Created by 김민지 on 2022/04/26.
//  MenuViewController Mock

import XCTest
@testable import FilmRecord

final class MockMenuViewController: MenuProtocol {
    var isCalledSetupAppearance = false
    var isCalledSetupView = false
    var isCalledApplyFont = false
    var isCalledDismiss = false
    var isCalledDidTappedMenu = false
    var isCalledDidTappedApps = false

    func setupAppearance() {
        isCalledSetupAppearance = true
    }

    func setupView() {
        isCalledSetupView = true
    }

    func applyFont() {
        isCalledApplyFont = true
    }

    func dismiss() {
        isCalledDismiss = true
    }

    func didTappedMenu(_ row: Int) {
        isCalledDidTappedMenu = true
    }

    func didTappedApps(_ row: Int) {
        isCalledDidTappedApps = true
    }
}
