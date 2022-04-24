//
//  HomePresenterTests.swift
//  HomePresenterTests
//
//  Created by 김민지 on 2022/03/25.
//  HomePresenter Unit Test

import XCTest
@testable import FilmRecord

class HomePresenterTests: XCTestCase {
    var sut: HomePresenter!

    var viewController: MockHomeViewController!
    var userDefaultsManager: MockUserDefaultsManager!

    var reviews: [Review] = [Review.TEST]

    var collectionView: UICollectionView!
    let indexPath = IndexPath(row: 0, section: 0)

    override func setUp() {
        super.setUp()

        viewController = MockHomeViewController()
        userDefaultsManager = MockUserDefaultsManager()

        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        collectionView.register(
            HomeCollectionViewCell.self,
            forCellWithReuseIdentifier: HomeCollectionViewCell.identifier
        )

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
        XCTAssertTrue(viewController.isCalledApplyFont)
    }

    func test_didTappedLeftBarButton이_요청되면() {
        sut.didTappedLeftBarButton()

        XCTAssertTrue(viewController.isCalledPushToMenuViewController)
    }

    func test_didTappedRightBarButton이_요청되면() {
        sut.didTappedRightBarButton()

        XCTAssertTrue(viewController.isCalledPushToSearchMovieViewController)
    }

    func test_didTappedLikeButton이_요청될때_review의_favorite이_true면() {
        sut.reviews = reviews
        sut.reviews[0].favorite = true
        sut.didTappedLikeButton(UIButton())

        XCTAssertTrue(viewController.isCalledShowToast)
        XCTAssertTrue(userDefaultsManager.isCalledOverwriteReview)
        XCTAssertTrue(viewController.isCalledReloadCollectionView)
    }

    func test_didTappedLikeButton이_요청될때_review의_favorite이_false면() {
        sut.reviews = reviews
        sut.didTappedLikeButton(UIButton())

        XCTAssertTrue(viewController.isCalledShowToast)
        XCTAssertTrue(userDefaultsManager.isCalledOverwriteReview)
        XCTAssertTrue(viewController.isCalledReloadCollectionView)
    }

    func test_collectionView의_didSelectItemAt이_요청되면() {
        sut.reviews = reviews
        sut.collectionView(collectionView, didSelectItemAt: indexPath)

        XCTAssertTrue(viewController.isCalledPushToDetailViewController)
    }
}
