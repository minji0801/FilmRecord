//
//  EnterRatingPresenterTests.swift
//  FilmRecordTests
//
//  Created by 김민지 on 2022/04/25.
//  EnterRatingPresent Unit Test

import XCTest
@testable import FilmRecord

final class EnterRatingPresenterTests: XCTestCase {
    var sut: EnterRatingPresenter!

    var viewController: MockEnterRatingViewController!

    var movie: Movie!
    var review: Review!
    var isEditing: Bool!

    override func setUp() {
        super.setUp()

        viewController = MockEnterRatingViewController()

        movie = Movie.TEST
        review = Review.TEST
        isEditing = false

        sut = EnterRatingPresenter(
            viewController: viewController,
            movie: movie,
            review: review,
            isEditing: isEditing
        )
    }

    override func tearDown() {
        sut = nil
        isEditing = nil
        review = nil
        movie = nil
        viewController = nil

        super.tearDown()
    }

    func test_viewDidLoad가_요청되면() {
        sut.viewDidLoad()

        XCTAssertTrue(viewController.isCalledSetupAppearance)
        XCTAssertTrue(viewController.isCalledSetupNavigationBar)
        XCTAssertTrue(viewController.isCalledSetupView)
        XCTAssertTrue(viewController.isCalledApplyFont)
    }

    func test_didTappedLeftBarButton이_요청되면() {
        sut.didTappedLeftBarButton()

        XCTAssertTrue(viewController.isCalledPopViewController)
    }

    func test_didTappedRightBarButton이_요청되면() {
        let rating: Double = 3.0
        sut.didTappedRightBarButton(rating: rating)

        XCTAssertTrue(viewController.isCalledPushToReviewWriteViewController)
    }
}
