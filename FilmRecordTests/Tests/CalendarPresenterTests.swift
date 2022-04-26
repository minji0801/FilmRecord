//
//  CalendarPresenterTests.swift
//  FilmRecordTests
//
//  Created by 김민지 on 2022/04/26.
//

import FSCalendar
import XCTest
@testable import FilmRecord

final class CalendarPresenterTests: XCTestCase {
    var sut: CalendarPresenter!

    var viewController: MockCalendarViewController!
    var userDefaultsManager: MockUserDefaultsManager!

    var events: [Date]!
    var reviews: [Review]!

    var formatter: DateFormatter = {
       let formatter = DateFormatter()
       formatter.locale = Locale(identifier: "ko_KR")
       formatter.dateFormat = "yyyy년 M월 d일 EEEE"

       return formatter
   }()

    let tableView: UITableView = UITableView()
    let indexPath: IndexPath = IndexPath(row: 0, section: 0)

    override func setUp() {
        super.setUp()

        viewController = MockCalendarViewController()
        userDefaultsManager = MockUserDefaultsManager()

        events = [formatter.date(from: "2022년 1월 1일 토요일")!]
        reviews = [Review.TEST]

        sut = CalendarPresenter(
            viewController: viewController,
            userDefaultsManager: userDefaultsManager
        )
    }

    override func tearDown() {
        sut = nil
        reviews = nil
        events = nil
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
        XCTAssertTrue(viewController.isCalledMoveToToday)
    }

    func test_viewWillAppear가_요청되면() {
        sut.viewWillAppear()

        XCTAssertTrue(userDefaultsManager.isCalledGetReviews)
        XCTAssertTrue(viewController.isCalledReloadTableView)
        XCTAssertTrue(viewController.isCalledApplyFont)
    }

    func test_didTappedLeftBarButton이_요청되면() {
        sut.didTappedLeftBarButton()

        XCTAssertTrue(viewController.isCalledPushToMenuViewController)
    }

    func test_didTappedRightBarButton이_요청되면() {
        sut.didTappedRightBarButton()

        XCTAssertTrue(viewController.isCalledMoveToToday)
    }

    func test_calendar의_didSelect이_요청되면() {
        sut.reviews = reviews
        let date = formatter.date(from: "2022년 1월 1일 토요일")!
        sut.calendar(FSCalendar(), didSelect: date, at: FSCalendarMonthPosition(rawValue: 0)!)

        XCTAssertTrue(userDefaultsManager.isCalledGetReviews)
        XCTAssertTrue(viewController.isCalledReloadTableView)
    }

    func test_calendar의_numberOfEventsFor이_요청될때_event가_있으면() {
        sut.events = events
        let date = formatter.date(from: "2022년 1월 1일 토요일")!
        let events = sut.calendar(FSCalendar(), numberOfEventsFor: date)

        XCTAssertEqual(events, 1)
    }

    func test_calendar의_numberOfEventsFor이_요청될때_event가_없으면() {
        sut.events = events
        let date = formatter.date(from: "2022년 1월 2일 일요일")!
        let events = sut.calendar(FSCalendar(), numberOfEventsFor: date)

        XCTAssertEqual(events, 0)
    }

    func test_tableView의_numberOfRowsInSection이_요청되면() {
        sut.reviews = reviews
        let rows = sut.tableView(tableView, numberOfRowsInSection: 0)

        XCTAssertNotNil(rows)
    }

    func test_tableView의_cellForRowAt이_요청되면() {
        sut.reviews = reviews
        tableView.register(
            CalendarTableViewCell.self,
            forCellReuseIdentifier: CalendarTableViewCell.identifier
        )
        let cell = sut.tableView(tableView, cellForRowAt: indexPath)

        XCTAssertNotNil(cell)
    }

    func test_tableView의_heightForRowAt이_요청되면() {
        let height = sut.tableView(tableView, heightForRowAt: indexPath)

        XCTAssertNotNil(height)
    }

    func test_tableView의_didSelectRowAt이_요청되면() {
        sut.reviews = reviews
        sut.tableView(tableView, didSelectRowAt: indexPath)

        XCTAssertTrue(viewController.isCalledPushToDetailViewController)
    }
}
