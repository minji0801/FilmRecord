//
//  MockFavoriteViewController.swift
//  FilmRecordTests
//
//  Created by 김민지 on 2022/04/26.
//  FavoriteViewController Mock

import XCTest
@testable import FilmRecord

final class MockFavoriteViewController: FavoriteProtocol {
    var isCalledSetupAppearance = false
    var isCalledSetupNavigationBar = false
    var isCalledSetupNoti = false
    var isCalledSetupView = false
    var isCalledApplyFont = false
    var isCalledPushToMenuViewController = false
    var isCalledReloadCollectionView = false
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
        isCalledApplyFont =  true
    }

    func pushToMenuViewController() {
        isCalledPushToMenuViewController = true
    }

    func reloadCollectionView() {
        isCalledReloadCollectionView = true
    }

    func pushToDetailViewController(review: Review) {
        isCalledPushToDetailViewController = true
    }
}
