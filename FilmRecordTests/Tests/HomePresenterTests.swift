//
//  HomePresenterTests.swift
//  HomePresenterTests
//
//  Created by 김민지 on 2022/03/25.
//  HomePresenter UnitTest

import XCTest
@testable import FilmRecord

class HomePresenterTests: XCTestCase {
    var sut: HomePresenter!

    var viewController: MockHomeViewController!
    var userDefaultsManager: MockUserDefaultsManager!

    override func setUp() {
        super.setUp()

        viewController = MockHomeViewController()
        userDefaultsManager = MockUserDefaultsManager()

        sut = HomePresenter(
            viewController: viewController,
            userDefaultsManager: userDefaultsManager
        )
    }

    override func tearDown() {
        sut = nil
        userDefaultsManager = nil
        viewController = nil

        super.tearDown()
    }

    func test_viewDidLoad가_요청되면() {
        sut.viewDidLoad()

        XCTAssertTrue(viewController.isCalledSetupAppearance)
        XCTAssertTrue(viewController.isCalledSetupNavigationBar)
        XCTAssertTrue(viewController.isCalledSetupNoti)
        XCTAssertTrue(viewController.isCalledSetupView)
    }

    func test_viewWillAppear가_요청되면() {
        sut.viewWillAppear()

        XCTAssertTrue(userDefaultsManager.isCalledGetReviews)
        XCTAssertTrue(viewController.isCalledReloadCollectionView)
    }

    func test_didTappedLeftBarButton이_요청되면() {
        sut.didTappedLeftBarButton()

        XCTAssertTrue(viewController.isCalledPushToMenuViewController)
    }

    func test_didTappedRightBarButton이_요청되면() {
        sut.didTappedRightBarButton()

        XCTAssertTrue(viewController.isCalledPushToSearchMovieViewController)
    }

    // TODO:  @objc func은 어떻게 Test를 작성하지?
//    func test_didTappedLikeButton이_요청될때_review의_favorite이_true면() {
//        sut.didTappedLikeButton(button)
//
//        XCTAssertTrue(viewController.isCalledShowToast)
//        XCTAssertTrue(userDefaultsManager.isCalledOverwriteReview)
//        XCTAssertTrue(viewController.isCalledReloadCollectionView)
//    }
}
