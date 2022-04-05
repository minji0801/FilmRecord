//
//  CalendarPresenter.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/05.
//  리뷰 캘린더 Presenter

import FSCalendar
import Foundation

protocol CalendarProtocol: AnyObject {
    func setupNavigationBar()
    func setupNoti()
    func setupView()
    func setupEvents() -> [Date]
    func pushToMenuViewController()
    func moveToToday()
}

final class CalendarPresenter: NSObject {
    private weak var viewController: CalendarProtocol?
    private let userDefaultsManager: UserDefaultsManagerProtocol

    private var events: [Date] = []

    init(
        viewController: CalendarProtocol?,
        userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager()
    ) {
        self.viewController = viewController
        self.userDefaultsManager = userDefaultsManager
    }

    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupNoti()
        viewController?.setupView()
        events = setupEvents()
    }

    func didTappedLeftBarButton() {
        viewController?.pushToMenuViewController()
    }

    func didTappedRightBarButton() {
        viewController?.moveToToday()
    }

    func setupEvents() -> [Date] {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 M월 d일 EEEE"

        return userDefaultsManager.getReviews().map { review in
            formatter.date(from: review.date)!
        }
    }
}

// MARK: - FSCalendar
extension CalendarPresenter: FSCalendarDataSource, FSCalendarDelegate {
    /// 날짜 선택
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(date, "선택!")
    }

    /// 날짜 선택 해제
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(date, "선택 해제!")
    }

    /// 달력 이벤트 표시
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if events.contains(date) {
            return 1
        } else {
            return 0
        }
    }
}
