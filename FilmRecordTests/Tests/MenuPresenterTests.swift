//
//  MenuPresenterTests.swift
//  FilmRecordTests
//
//  Created by 김민지 on 2022/04/26.
//  MenuPresenter Unit Test

import XCTest
@testable import FilmRecord

final class MenuPresenterTests: XCTestCase {
    var sut: MenuPresenter!

    var viewController: MockMenuViewController!
    let tableView: UITableView = UITableView()
    let indexPath: IndexPath = IndexPath(row: 0, section: 0)

    override func setUp() {
        super.setUp()

        viewController = MockMenuViewController()

        sut = MenuPresenter(viewController: viewController)
    }

    override func tearDown() {
        sut = nil
        viewController = nil

        super.tearDown()
    }

    func test_viewDidLoad가_요청되면() {
        sut.viewDidLoad()

        XCTAssertTrue(viewController.isCalledSetupAppearance)
        XCTAssertTrue(viewController.isCalledSetupView)
        XCTAssertTrue(viewController.isCalledApplyFont)
    }

    func test_tableView의_numberOfRowsInSection이_요청되면() {
        let numberOfRows = sut.tableView(tableView, numberOfRowsInSection: 0)

        XCTAssertNotNil(numberOfRows)
    }

    func test_tableView의_cellForRowAt이_요청될때_tag가_0이면() {
        tableView.tag = 0
        tableView.register(
            MenuTableViewCell.self,
            forCellReuseIdentifier: MenuTableViewCell.identifier
        )
        let cell = sut.tableView(tableView, cellForRowAt: indexPath)

        XCTAssertNotNil(cell)
    }

    func test_tableView의_cellForRowAt이_요청될때_tag가_1이면() {
        tableView.tag = 1
        tableView.register(
            AppsTableViewCell.self,
            forCellReuseIdentifier: AppsTableViewCell.identifier
        )
        let cell = sut.tableView(tableView, cellForRowAt: indexPath)

        XCTAssertNotNil(cell)
    }

    func test_tableView의_heightForRowAt이_요청되면() {
        let height = sut.tableView(tableView, heightForRowAt: indexPath)

        XCTAssertNotNil(height)
    }

    func test_tableView의_didSelectRowAt이_요청될때_tag가_0이면() {
        tableView.tag = 0
        sut.tableView(tableView, didSelectRowAt: indexPath)

        XCTAssertTrue(viewController.isCalledDismiss)
        XCTAssertTrue(viewController.isCalledDidTappedMenu)
        XCTAssertFalse(viewController.isCalledDidTappedApps)
    }

    func test_tableView의_didSelectRowAt이_요청될때_tag가_1이면() {
        tableView.tag = 1
        sut.tableView(tableView, didSelectRowAt: indexPath)

        XCTAssertTrue(viewController.isCalledDismiss)
        XCTAssertFalse(viewController.isCalledDidTappedMenu)
        XCTAssertTrue(viewController.isCalledDidTappedApps)
    }
}
