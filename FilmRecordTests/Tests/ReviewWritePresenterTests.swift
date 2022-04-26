//
//  ReviewWritePresenterTests.swift
//  FilmRecordTests
//
//  Created by 김민지 on 2022/04/25.
//  ReviewWritePresenter Unit Test

import XCTest
@testable import FilmRecord

final class ReviewWritePresenterTests: XCTestCase {
    var sut: ReviewWritePresenter!

    var viewController: MockReviewWriteViewController!
    var userDefaultsManager: MockUserDefaultsManager!

    var movie: Movie!
    var rating: Double!
    var review: Review!
    var isEditing: Bool!

    override func setUp() {
        super.setUp()

        viewController = MockReviewWriteViewController()
        userDefaultsManager = MockUserDefaultsManager()

        movie = Movie.TEST
        rating = 3.0
        review = Review.TEST
        isEditing = false

        sut = ReviewWritePresenter(
            viewController: viewController,
            userDefaultsManager: userDefaultsManager,
            movie: movie,
            rating: rating,
            review: review,
            isEditing: isEditing
        )
    }

    override func tearDown() {
        sut = nil
        isEditing = nil
        review = nil
        rating = nil
        movie = nil
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
        XCTAssertTrue(viewController.isCalledApplyFont)
    }

    func test_touchesBegan이_요청되면() {
        sut.touchesBegan()

        XCTAssertTrue(viewController.isCalledKeyboardDown)
    }

    func test_didTappedLeftBarButton이_요청되면() {
        sut.didTappedLeftBarButton()

        XCTAssertTrue(viewController.isCalledPopViewController)
    }

    func test_didTappedRightBarButton이_요청될때_isEditing이_true면() {
        sut = ReviewWritePresenter(
            viewController: viewController,
            userDefaultsManager: userDefaultsManager,
            movie: movie,
            rating: rating,
            review: review,
            isEditing: true
        )

        let date: String = "2022년 01월 01일"
        let place: String? = ""
        let with: String? = ""
        let content: String? = ""
        sut.didTappedRightBarButton(date: date, place: place, with: with, content: content)

        XCTAssertFalse(userDefaultsManager.isCalledGetReviewId)
        XCTAssertTrue(userDefaultsManager.isCalledEditReview)
        XCTAssertFalse(userDefaultsManager.isCalledSetReview)
        XCTAssertFalse(userDefaultsManager.isCalledSetReviewId)
        XCTAssertTrue(viewController.isCalledPopToRootViewController)
    }

    func test_didTappedRightBarButton이_요청될때_isEditing이_false면() {
        let date: String = "2022년 01월 01일"
        let place: String? = ""
        let with: String? = ""
        let content: String? = ""
        sut.didTappedRightBarButton(date: date, place: place, with: with, content: content)

        XCTAssertTrue(userDefaultsManager.isCalledGetReviewId)
        XCTAssertFalse(userDefaultsManager.isCalledEditReview)
        XCTAssertTrue(userDefaultsManager.isCalledSetReview)
        XCTAssertTrue(userDefaultsManager.isCalledSetReviewId)
        XCTAssertTrue(viewController.isCalledPopToRootViewController)
    }

    func test_didTappedDateLabel이_요청되면() {
        sut.didTappedDateLabel()

        XCTAssertTrue(viewController.isCalledShowDatePickerAlertViewController)
    }

    func test_textFieldShouldReturn이_요청되면() {
        let bool = sut.textFieldShouldReturn(UITextField())

        XCTAssertEqual(bool, true)
    }

    func test_textViewDidBeginEditing이_요청될때_textColor가_label이_아니면() {
        let textView = UITextView()
        textView.text = "리뷰를 입력해주세요"
        textView.textColor = .systemGray3
        sut.textViewDidBeginEditing(textView)

        XCTAssertEqual(textView.text, "")
        XCTAssertEqual(textView.textColor, .label)
    }

    func test_textViewDidEndEditing이_요청될때_textView의_text가_비었으면() {
        let textView = UITextView()
        textView.text = ""
        sut.textViewDidEndEditing(textView)

        XCTAssertEqual(textView.text, "리뷰를 작성해주세요.")
        XCTAssertEqual(textView.textColor, .systemGray3)
    }
}
