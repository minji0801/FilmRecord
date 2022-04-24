//
//  DetailPresenterTests.swift
//  FilmRecordTests
//
//  Created by 김민지 on 2022/04/24.
//  DetailPresenter Unit Test

import XCTest
@testable import FilmRecord

final class DetailPresenterTests: XCTestCase {
    var sut: DetailPresenter!

    var viewcontroller: MockDetailViewController!
    var userDefaultsManager: MockUserDefaultsManager!
    var review: Review!

    override func setUp() {
        super.setUp()

        viewcontroller = MockDetailViewController()
        userDefaultsManager = MockUserDefaultsManager()
        review = Review.EMPTY

        sut = DetailPresenter(
            viewController: viewcontroller,
            userDefaultsManager: userDefaultsManager,
            review: review
        )
    }

    override func tearDown() {
        sut = nil
        review = nil
        userDefaultsManager = nil
        viewcontroller = nil

        super.tearDown()
    }

    func test_viewDidLoad가_요청되면() {
        sut.viewDidLoad()

        XCTAssertTrue(viewcontroller.isCalledSetupAppearance)
        XCTAssertTrue(viewcontroller.isCalledSetupNavigationBar)
        XCTAssertTrue(viewcontroller.isCalledSetupNoti)
        XCTAssertTrue(viewcontroller.isCalledSetupGesture)
        XCTAssertTrue(viewcontroller.isCalledSetupView)
        XCTAssertTrue(viewcontroller.isCalledApplyFont)
        XCTAssertTrue(viewcontroller.isCalledUpdateRightBarLikeButton)
    }

    func test_didTappedLeftBarButton이_요청되면() {
        sut.didTappedLeftBarButton()

        XCTAssertTrue(viewcontroller.isCalledPopViewController)
    }

    func test_didTappedRightBarLikeButton이_요청되면() {
        sut.didTappedRightBarLikeButton()

        XCTAssertTrue(userDefaultsManager.isCalledEditReview)
        XCTAssertTrue(viewcontroller.isCalledUpdateRightBarLikeButton)
        XCTAssertTrue(viewcontroller.isCalledShowToast)
    }

    func test_editNotification이_요청되면() {
        sut.editNotification()

        XCTAssertTrue(viewcontroller.isCalledPushToEnterRatingViewController)
    }

    func test_deleteNotification이_요청되면() {
        sut.deleteNotification()

        XCTAssertTrue(viewcontroller.isCalledShowDeleteAlert)
    }

    func test_deleteReviewNotification이_요청되면() {
        sut.deleteReviewNotification()

        XCTAssertTrue(userDefaultsManager.isCalledDeleteReview)
        XCTAssertTrue(viewcontroller.isCalledPopViewController)
    }
}
