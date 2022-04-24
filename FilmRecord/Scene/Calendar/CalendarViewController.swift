//
//  CalendarViewController.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/05.
//  리뷰 캘린더 화면

import FSCalendar
import SideMenu
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
            image: UIImage(systemName: "arrow.clockwise"),
            style: .plain,
            target: self,
            action: #selector(didTappedRightBarButton)
        )

        return rightBarButtonItem
    }()

    /// 캘린더 뷰
    private lazy var calendarView: FSCalendar = {
        let view = FSCalendar()
        view.scrollDirection = .vertical
        view.locale = Locale(identifier: "ko_KR")
        view.appearance.caseOptions = FSCalendarCaseOptions.weekdayUsesUpperCase

        view.appearance.headerDateFormat = "YYYY년 M월"
        view.appearance.headerTitleColor = .label
        view.appearance.headerMinimumDissolvedAlpha = 0.0
        view.layer.cornerRadius = 12.0

        view.appearance.titleDefaultColor = .label
        view.appearance.weekdayTextColor = .label
        view.appearance.todayColor = .systemGray
        view.appearance.titleWeekendColor = .systemRed
        view.backgroundColor = .secondarySystemBackground

        view.dataSource = presenter
        view.delegate = presenter

        return view
    }()

    /// 리뷰 테이블 뷰
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.dataSource = presenter
        tableView.delegate = presenter

        tableView.register(
            CalendarTableViewCell.self,
            forCellReuseIdentifier: CalendarTableViewCell.identifier
        )

        return tableView
    }()

    /// 화면이 어두워지는  뷰
    private lazy var coverView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        view.isHidden = true

        return view
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
    /// 화면 Appearance 설정
    func setupAppearance() {
        DarkModeManager.applyAppearance(mode: DarkModeManager.getAppearance(), viewController: self)
    }

    /// 네비게이션 바 구성
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.title = "리뷰 캘린더"
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

        [tableView, calendarView, coverView].forEach {
            view.addSubview($0)
        }

        let spacing: CGFloat = 16.0

        tableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(calendarView.snp.bottom).offset(spacing)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        calendarView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(spacing)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(spacing)
            $0.height.equalTo(view.snp.height).multipliedBy(0.4)
        }

        coverView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

    }

    /// 폰트 적용
    func applyFont() {
        let font = FontManager.getFont()

        navigationController?.navigationBar.titleTextAttributes = [
            .font: font.extraLargeFont
        ]

        calendarView.appearance.headerTitleFont = font.largeFont
        calendarView.appearance.weekdayFont = font.mediumFont
        calendarView.appearance.titleFont = font.mediumFont
    }

    /// 메뉴 화면 push
    func pushToMenuViewController() {
        coverView.isHidden = false
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
        case 4:
            let settingsViewController = SettingsViewController()
            navigationController?.setViewControllers([settingsViewController], animated: true)
        default:
            break
        }
    }
}

// MARK: - SideMenu
extension CalendarViewController: SideMenuNavigationControllerDelegate {

    /// 메뉴가 사라지려고 할 때
    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        coverView.isHidden = true
    }
}
