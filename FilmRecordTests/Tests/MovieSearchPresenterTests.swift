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
    var fromHome: Bool!

    override func setUp() {
        super.setUp()

        viewController = MockMovieSearchViewController()
        movieSearchManager = MockMovieSearchManager()
        userDefaultsManager = MockUserDefaultsManager()
        fromHome = true

        sut = MovieSearchPresenter(
            viewController: viewController,
            movieSearchManager: movieSearchManager,
            userDefaultsManager: userDefaultsManager,
            fromHome: fromHome
        )
    }

    override func tearDown() {
        sut = nil
        fromHome = nil
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

    func test_pullToRefresh가_요청되면() {
        sut.pullToRefresh()

        XCTAssertTrue(movieSearchManager.isCalledRequest)
    }

    func test_didTappedLeftBarButton이_요청되면() {
        sut.didTappedLeftBarButton()

        XCTAssertTrue(viewController.isCalledPopViewController)
    }

    /// 검색어가 있는지 없는지에 따라 나누지 않은 이유: 검색어가 없으면 Search 버튼이 비활성화됨
    func test_searchBarSearchButtonClicked가_요청되면() {
        let searchBar = UISearchBar()
        searchBar.text = "검색어"

        sut.searchBarSearchButtonClicked(searchBar)

        XCTAssertTrue(movieSearchManager.isCalledRequest)
    }

    func test_didPresentSearchController가_요청되면() {
        let searchController = UISearchController()
        sut.didPresentSearchController(searchController)

        DispatchQueue.main.async {
            XCTAssertTrue(searchController.searchBar.isFirstResponder)
        }
    }

    // TODO: numberOfItemsInSection는 어떻게 테스트 작성하지?
//    func test_collectionView의_numberOfItemsInSection가_요청되면() {
//        let collectionView = UICollectionView()
//        let section = 0
//        let moviesCount = sut.collectionView(collectionView, numberOfItemsInSection: section)
//    }
}
