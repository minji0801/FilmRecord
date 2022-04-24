//
//  MockMovieSearchViewController.swift
//  FilmRecordTests
//
//  Created by 김민지 on 2022/04/24.
//  MovieSearchViewController Mock

import XCTest
@testable import FilmRecord

final class MockMovieSearchViewController: MovieSearchProtocol {
    var movie: Movie!

    var isCalledSetupAppearance = false
    var isCalledSetupNavigationBar = false
    var isCalledSetupView = false
    var isCalledApplyFont = false
    var isCalledReloadCollectionView = false
    var isCalledActiveSearchController = false
    var isCalledKeyboardDown = false
    var isCalledEndRefreshing = false
    var isCalledPopViewController = false
    var isCalledPushToEnterRatingViewController = false

    func setupAppearance() {
        isCalledSetupAppearance =  true
    }

    func setupNavigationBar() {
        isCalledSetupNavigationBar = true
    }

    func setupView() {
        isCalledSetupView = true
    }

    func applyFont() {
        isCalledApplyFont = true
    }

    func reloadCollectionView() {
        isCalledReloadCollectionView = true
    }

    func activeSearchController() {
        isCalledActiveSearchController = true
    }

    func keyboardDown() {
        isCalledKeyboardDown = true
    }

    func endRefreshing() {
        isCalledEndRefreshing = true
    }

    func popViewController() {
        isCalledPopViewController = true
    }

    func pushToEnterRatingViewController(movie: Movie) {
        isCalledPushToEnterRatingViewController = true
        self.movie = movie
    }
}
