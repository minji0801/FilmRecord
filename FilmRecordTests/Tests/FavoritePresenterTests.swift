//
//  FavoritePresenterTests.swift
//  FilmRecordTests
//
//  Created by 김민지 on 2022/04/26.
//  FavoritePresenter Unit Test

import XCTest
@testable import FilmRecord

final class FavoritePresenterTests: XCTestCase {
    var sut: FavoritePresenter!

    var viewController: MockFavoriteViewController!
    var userDefaultsManager: MockUserDefaultsManager!

    var reviews: [Review]!

    var collectionView: UICollectionView!
    var indexPath: IndexPath!

    override func setUp() {
        super.setUp()

        viewController = MockFavoriteViewController()
        userDefaultsManager = MockUserDefaultsManager()

        reviews = [Review.TEST]

        collectionView = UICollectionView(
            frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout()
        )
        indexPath = IndexPath(row: 0, section: 0)

        sut = FavoritePresenter(
            viewController: viewController,
            userDefaultsManager: userDefaultsManager
        )
    }

    override func tearDown() {
        sut = nil
        collectionView = nil
        indexPath = nil
        reviews = nil
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

    func test_collectionView의_numberOfItemsInSection이_요청되면() {
        let section = sut.collectionView(collectionView, numberOfItemsInSection: 0)

        XCTAssertNotNil(section)
    }

    func test_collectionView의_cellForItemAt이_요청되면() {
        sut.reviews = reviews
        collectionView.register(
            FavoriteCollectionViewCell.self,
            forCellWithReuseIdentifier: FavoriteCollectionViewCell.identifier
        )
        let cell = sut.collectionView(collectionView, cellForItemAt: indexPath)

        XCTAssertNotNil(cell)
    }

    func test_collectionView의_sizeForItemAt이_요청되면() {
        let size = sut.collectionView(collectionView, layout: UICollectionViewLayout(), sizeForItemAt: indexPath)

        XCTAssertNotNil(size)
    }

    func test_collectionView의_insetForSectionAt이_요청되면() {
        let edgeInsets = sut.collectionView(collectionView, layout: UICollectionViewLayout(), insetForSectionAt: 0)

        XCTAssertNotNil(edgeInsets)
    }

    func test_collectionView의_didSelectItemAt이_요청되면() {
        sut.reviews = reviews
        sut.collectionView(collectionView, didSelectItemAt: indexPath)

        XCTAssertTrue(viewController.isCalledPushToDetailViewController)
    }
}
