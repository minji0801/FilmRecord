//
//  MockHomeViewController.swift
//  FilmRecordTests
//
//  Created by 김민지 on 2022/04/23.
//  HomeViewController Mock

import XCTest
@testable import FilmRecord

final class MockHomeViewController: HomeProtocol {
    var isCalledSetupAppearance = false
    var isCalledSetupNavigationBar = false
    var isCalledSetupNoti = false
    var isCalledSetupView = false
    var isCalledPushToMenuViewController = false
    var isCalledPushToSearchMovieViewController = false
    var isCalledReloadCollectionView = false
    var isCalledPushToDetailViewController = false
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

    func setupView() {
        isCalledSetupView = true
    }

    func pushToMenuViewController() {
        isCalledPushToMenuViewController = true
    }

    func pushToSearchMovieViewController() {
        isCalledPushToSearchMovieViewController = true
    }

    func reloadCollectionView() {
        isCalledReloadCollectionView = true
    }

    func pushToDetailViewController(review: Review) {
        isCalledPushToDetailViewController = true
    }

    func showToast(_ show: Bool) {
        isCalledShowToast = true
    }
}
