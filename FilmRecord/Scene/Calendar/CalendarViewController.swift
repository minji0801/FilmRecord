//
//  CalendarViewController.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/05.
//  리뷰 캘린더 화면

import FSCalendar
import SnapKit
import UIKit

final class CalendarViewController: UIViewController {
    private lazy var presenter = CalendarPresenter(viewController: self)

    /// Left Bar Button: 메뉴 버튼
    private lazy var leftBarButtonItem: UIBarButtonItem = {
        let leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "line.3.horizontal"),
            style: .plain,
            target: self,
            action: #selector(didTappedLeftBarButton)
        )

        return leftBarButtonItem
    }()

    /// Right Bar Button: 오늘 버튼
    private lazy var rightBarButtonItem: UIBarButtonItem = {
        let rightBarButtonItem = UIBarButtonItem(
            title: "오늘",
            style: .plain,
            target: self,
            action: #selector(didTappedRightBarButton)
        )

        return rightBarButtonItem
    }()

    private lazy var calendarView: FSCalendar = {
        let view = FSCalendar()
        view.scrollDirection = .vertical
        view.locale = Locale(identifier: "ko_KR")
        view.appearance.caseOptions = FSCalendarCaseOptions.weekdayUsesUpperCase

        view.appearance.headerTitleFont = FontManager().largeFont()
        view.appearance.weekdayFont = FontManager().mediumFont()
        view.appearance.titleFont = FontManager().mediumFont()

        view.appearance.headerDateFormat = "YYYY년 M월"
        view.appearance.headerTitleColor = .label
        view.appearance.headerMinimumDissolvedAlpha = 0.0

        view.appearance.titleDefaultColor = .label
        view.appearance.weekdayTextColor = .label
        view.appearance.todayColor = .systemGray
        view.appearance.titleWeekendColor = .systemRed

        view.dataSource = presenter
        view.delegate = presenter

        return view
    }()

    /// 리뷰 테이블 뷰
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = presenter
        tableView.delegate = presenter

        tableView.register(
            CalendarTableViewCell.self,
            forCellReuseIdentifier: CalendarTableViewCell.identifier
        )

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        presenter.viewWillApper()
    }
}

// MARK: - CalendarProtocol Function
extension CalendarViewController: CalendarProtocol {

    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.title = "review calendar"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: FontManager().largeFont()
        ]
    }

    /// 노티피케이션 구성
    func setupNoti() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didDismissMenuViewController(_:)),
            name: NSNotification.Name("DismissMenu"),
            object: nil
        )
    }

    /// 뷰 구성
    func setupView() {
        view.backgroundColor = .systemBackground

        [calendarView, tableView].forEach {
            view.addSubview($0)
        }

        calendarView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(350)
        }

        tableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(calendarView.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    /// 메뉴 화면 push
    func pushToMenuViewController() {
        let menuNavigationController = MenuNavigationController(rootViewController: MenuViewController())
        present(menuNavigationController, animated: true)
    }

    /// 캘린더에서 오늘 날짜로 이동
    func moveToToday() {
        calendarView.select(Date(), scrollToDate: true)
    }

    /// Table view Reload
    func reloadTableView() {
        tableView.reloadData()
    }

    /// 리뷰 상세 화면 push
    func pushToDetailViewController(review: Review) {
        let detailViewController = DetailViewController(review: review)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: - @objc Function
extension CalendarViewController {

    /// 메뉴 버튼 클릭: 메뉴 화면 보여주기
    @objc func didTappedLeftBarButton() {
        presenter.didTappedLeftBarButton()
    }

    /// 오늘 버튼 클릭: 캘린더 오늘 날짜로 이동
    @objc func didTappedRightBarButton() {
        presenter.didTappedRightBarButton()
    }

    /// 메뉴 뷰 사라지고 받는 노티
    @objc func didDismissMenuViewController(_ notification: Notification) {
        guard let object: Int = notification.object as? Int else { return }
        // 자기 자신 제외하고 컨트롤하기
        switch object {
        case 0:
            let homeViewContoller = HomeViewController()
            navigationController?.setViewControllers([homeViewContoller], animated: true)
        case 2:
            let favoriteViewController = FavoriteViewController()
            navigationController?.setViewControllers([favoriteViewController], animated: true)
        case 3:
            let toWatchViewController = ToWatchViewController()
            navigationController?.setViewControllers([toWatchViewController], animated: true)
        default:
            break
        }
    }
}