//
//  MovieSearchPresenterTests.swift
//  FilmRecordTests
//
//  Created by 김민지 on 2022/04/24.
//  MovieSearchPresenter Unit Test

import XCTest
@testable import FilmRecord

final class MovieSearchPresenterTests: XCTestCase {
    var sut: MovieSearchPresenter!

    var viewController: MockMovieSearchViewController!
    var movieSearchManager: MockMovieSearchManager!
    var userDefaultsManager: MockUserDefaultsManager!

    var movies: [Movie]!
    var fromHome: Bool!

    var collectionView: UICollectionView!
    var indexPath: IndexPath!

    override func setUp() {
        super.setUp()

        viewController = MockMovieSearchViewController()
        movieSearchManager = MockMovieSearchManager()
        userDefaultsManager = MockUserDefaultsManager()

        movies = [Movie.TEST]
        fromHome = true

        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        indexPath = IndexPath(row: 0, section: 0)

        sut = MovieSearchPresenter(
            viewController: viewController,
            movieSearchManager: movieSearchManager,
            userDefaultsManager: userDefaultsManager,
            fromHome: fromHome
        )
    }

    override func tearDown() {
        sut = nil
        indexPath = nil
        collectionView = nil
        fromHome = nil
        movies = nil
        userDefaultsManager = nil
        movieSearchManager = nil
        viewController = nil

        super.tearDown()
    }

    func test_viewDidLoad가_요청되면() {
        sut.viewDidLoad()

        XCTAssertTrue(viewController.isCalledSetupAppearance)
        XCTAssertTrue(viewController.isCalledSetupNavigationBar)
        XCTAssertTrue(viewController.isCalledSetupView)
    }

    func test_viewWillAppear가_요청되면() {
        sut.viewWillAppear()

        XCTAssertTrue(viewController.isCalledApplyFont)
    }

    func test_viewDidAppear가_요청되면() {
        sut.viewDidAppear()

        XCTAssertTrue(viewController.isCalledActiveSearchController)
    }

    func test_pullToRefresh가_요청될때_request에_실패하면() {
        movieSearchManager.error = NSError() as Error
        sut.pullToRefresh()

        XCTAssertFalse(viewController.isCalledReloadCollectionView)
        XCTAssertFalse(viewController.isCalledEndRefreshing)
    }

    func test_pullToRefresh가_요청될때_request에_성공하면() {
        movieSearchManager.error = nil
        sut.pullToRefresh()

        XCTAssertTrue(viewController.isCalledReloadCollectionView)
        XCTAssertTrue(viewController.isCalledEndRefreshing)
    }

    func test_didTappedLeftBarButton이_요청되면() {
        sut.didTappedLeftBarButton()

        XCTAssertTrue(viewController.isCalledPopViewController)
    }

    /// 검색어가 있는지 없는지에 따라 나누지 않은 이유: 검색어가 없으면 Search 버튼이 비활성화됨
    func test_searchBarSearchButtonClicked가_요청되면() {
        sut.searchBarSearchButtonClicked(UISearchBar())

        XCTAssertTrue(movieSearchManager.isCalledRequest)
    }

    func test_didPresentSearchController가_요청되면() {
        let searchController = UISearchController()
        sut.didPresentSearchController(searchController)

//        DispatchQueue.main.async {
//            XCTAssertTrue(searchController.searchBar.isFirstResponder)
//        }
    }

    func test_collectionView의_numberOfItemsInSection가_요청되면() {
        sut.movies = movies
        let numberOfCells = sut.collectionView(collectionView, numberOfItemsInSection: 0)
        XCTAssertNotNil(numberOfCells)
    }

    func test_collectionView의_cellForItemAt이_요청되면() {
        sut.movies = movies
        collectionView.register(
            MovieSearchCollectionViewCell.self,
            forCellWithReuseIdentifier: MovieSearchCollectionViewCell.identifier
        )
        let cell = sut.collectionView(collectionView, cellForItemAt: indexPath)

        XCTAssertNotNil(cell)
    }

    func test_collectionView의_sizeForItemAt이_요청되면() {
        let size = sut.collectionView(collectionView, layout: UICollectionViewLayout(), sizeForItemAt: indexPath)

        XCTAssertNotNil(size)
    }

    func test_collectionView의_insetForSectionAt이_요청되면() {
        let edgeInsets = sut.collectionView(
            collectionView,
            layout: UICollectionViewLayout(),
            insetForSectionAt: indexPath.section
        )

        XCTAssertNotNil(edgeInsets)
    }

    func test_scrollViewWillBeginDragging이_요청되면() {
        sut.scrollViewWillBeginDragging(UIScrollView())

        XCTAssertTrue(viewController.isCalledKeyboardDown)
    }

    func test_collectionView의_willDisplay가_요청될때_request에_실패하면() {
        movieSearchManager.error = NSError() as Error

        sut.currentPage = 1
        sut.display = 3
        sut.collectionView(collectionView, willDisplay: UICollectionViewCell(), forItemAt: indexPath)

        XCTAssertFalse(viewController.isCalledReloadCollectionView)
        XCTAssertFalse(viewController.isCalledEndRefreshing)
    }

    func test_collectionView의_willDisplay가_요청될때_request에_성공하면() {
        movieSearchManager.error = nil

        sut.currentPage = 1
        sut.display = 3
        sut.collectionView(collectionView, willDisplay: UICollectionViewCell(), forItemAt: indexPath)

        XCTAssertTrue(viewController.isCalledReloadCollectionView)
        XCTAssertTrue(viewController.isCalledEndRefreshing)
    }

    func test_collectionView의_didSelectItemAt이_요청될때_fromHome이_true면() {
        sut.movies = movies
        sut.collectionView(collectionView, didSelectItemAt: indexPath)

        XCTAssertTrue(viewController.isCalledPushToEnterRatingViewController)
        XCTAssertFalse(userDefaultsManager.isCalledSetMovieToWatch)
        XCTAssertFalse(viewController.isCalledPopViewController)
    }

    func test_collectionView의_didSelectItemAt이_요청될때_fromHome이_false면() {
        sut = MovieSearchPresenter(
            viewController: viewController,
            movieSearchManager: movieSearchManager,
            userDefaultsManager: userDefaultsManager,
            fromHome: false
        )
        sut.movies = movies
        sut.collectionView(collectionView, didSelectItemAt: indexPath)

        XCTAssertFalse(viewController.isCalledPushToEnterRatingViewController)
        XCTAssertTrue(userDefaultsManager.isCalledSetMovieToWatch)
        XCTAssertTrue(viewController.isCalledPopViewController)
    }
}
