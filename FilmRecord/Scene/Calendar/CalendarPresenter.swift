//
//  CalendarPresenter.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/05.
//  리뷰 캘린더 Presenter

import FSCalendar
import Foundation

protocol CalendarProtocol: AnyObject {
    func setupAppearance()
    func setupNavigationBar()
    func setupNoti()
    func setupView()

    func applyFont()
    func pushToMenuViewController()
    func moveToToday()
    func reloadTableView()
    func pushToDetailViewController(review: Review)
}

final class CalendarPresenter: NSObject {
    private weak var viewController: CalendarProtocol?
    private let userDefaultsManager: UserDefaultsManagerProtocol

    var events: [Date] = []
    var reviews: [Review] = []

    private var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 M월 d일 EEEE"

        return formatter
    }()

    init(
        viewController: CalendarProtocol?,
        userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager()
    ) {
        self.viewController = viewController
        self.userDefaultsManager = userDefaultsManager
    }

    func viewDidLoad() {
        viewController?.setupAppearance()
        viewController?.setupNavigationBar()
        viewController?.setupNoti()
        viewController?.setupView()
        viewController?.moveToToday()
    }

    func viewWillAppear() {
        events = setupEvents()
        getReview(date: Date())
        viewController?.applyFont()
    }

    func didTappedLeftBarButton() {
        viewController?.pushToMenuViewController()
    }

    func didTappedRightBarButton() {
        getReview(date: Date())
        viewController?.moveToToday()
    }

    private func setupEvents() -> [Date] {
        return userDefaultsManager.getReviews().map { review in
            formatter.date(from: review.date)!
        }
    }

    /// 선택한 날짜에 해당하는 리뷰 가져오기
    private func getReview(date: Date) {
        reviews = userDefaultsManager.getReviews()

        let reviewDate = formatter.string(from: date)
        reviews = reviews.filter { $0.date == reviewDate }

        viewController?.reloadTableView()
    }
}

// MARK: - FSCalendar
extension CalendarPresenter: FSCalendarDataSource, FSCalendarDelegate {
    /// 날짜 선택
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        getReview(date: date)
    }

    /// 달력 이벤트 표시
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        guard events.contains(date) else { return 0 }
        return 1
    }
}

// MARK: - UITableView
extension CalendarPresenter: UITableViewDelegate, UITableViewDataSource {
    /// Row 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }

    /// Cell 구성
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CalendarTableViewCell.identifier
        ) as? CalendarTableViewCell else { return UITableViewCell() }

        let review = reviews[indexPath.row]
        cell.update(review)

        return cell
    }

    /// Cell 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }

    /// Cell 클릭
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let review = reviews[indexPath.row]
        viewController?.pushToDetailViewController(review: review)
    }
}
