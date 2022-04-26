//
//  ToWatchPresenterTests.swift
//  FilmRecordTests
//
//  Created by 김민지 on 2022/04/26.
//  ToWatchPresenter Unit Test

import XCTest
@testable import FilmRecord

final class ToWatchPresenterTests: XCTestCase {
    var sut: ToWatchPresenter!

    var viewController: MockToWatchViewController!
    var userDefaultsManager: MockUserDefaultsManager!

    var movies: [Watch]!

    var tableView: UITableView!
    var indexPath: IndexPath!

    override func setUp() {
        super.setUp()

        viewController = MockToWatchViewController()
        userDefaultsManager = MockUserDefaultsManager()

        movies = [Watch.TEST]

        tableView = UITableView()
        indexPath = IndexPath(row: 0, section: 0)

        sut = ToWatchPresenter(
            viewController: viewController,
            userDefaultsManager: userDefaultsManager
        )
    }

    override func tearDown() {
        sut = nil
        indexPath = nil
        tableView = nil
        movies = nil
        userDefaultsManager = nil
        viewController = nil

        super.tearDown()
    }

    func test_viewDidLoad가_요청되면() {
        sut.viewDidLoad()

        XCTAssertTrue(viewController.isCalledSetupAppearance)
        XCTAssertTrue(viewController.isCalledSetupNavigationBar)
        XCTAssertTrue(viewController.isCalledSetupNoti)
        XCTAssertTrue(viewController.isCalledsSetupView)
    }

    func test_viewWillAppear가_요청되면() {
        sut.viewWillAppear()

        XCTAssertTrue(userDefaultsManager.isCalledGetMovieToWatch)
        XCTAssertTrue(viewController.isCalledReloadTableView)
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

    func test_tableView의_numberOfRowsInSection이_요청되면() {
        let section = sut.tableView(tableView, numberOfRowsInSection: 0)

        XCTAssertNotNil(section)
    }

    func test_tableView의_cellForRowAt이_요청되면() {
        sut.movies = movies
        tableView.register(
            ToWatchTableViewCell.self,
            forCellReuseIdentifier: ToWatchTableViewCell.identifier
        )
        let cell = sut.tableView(tableView, cellForRowAt: indexPath)

        XCTAssertNotNil(cell)
    }

    func test_tableView의_heightForRowAt이_요청되면() {
        let height = sut.tableView(tableView, heightForRowAt: indexPath)

        XCTAssertNotNil(height)
    }

    func test_tableView의_didSelectRowAt이_요청되면() {
        sut.movies = movies
        sut.tableView(tableView, didSelectRowAt: indexPath)

        XCTAssertTrue(userDefaultsManager.isCalledOverwriteToWatch)
        XCTAssertTrue(viewController.isCalledReloadTableView)
    }

    func test_tableView의_trailingSwipeActionsConfigurationForRowAt이_요청되면() {
        sut.movies = movies
        let configuration = sut.tableView(
            tableView,
            trailingSwipeActionsConfigurationForRowAt: indexPath
        )

        XCTAssertNotNil(configuration)
        // TODO: DeleteAction Unit Test
    }
}

final class MockToWatchViewController: ToWatchProtocol {
    var isCalledSetupAppearance = false
    var isCalledSetupNavigationBar = false
    var isCalledSetupNoti = false
    var isCalledsSetupView = false
    var isCalledApplyFont = false
    var isCalledPushToMenuViewController = false
    var isCalledPushToSearchMovieViewController = false
    var isCalledReloadTableView = false

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
        isCalledsSetupView = true
    }

    func applyFont() {
        isCalledApplyFont = true
    }

    func pushToMenuViewController() {
        isCalledPushToMenuViewController = true
    }

    func pushToSearchMovieViewController() {
        isCalledPushToSearchMovieViewController = true
    }

    func reloadTableView() {
        isCalledReloadTableView = true
    }
}
