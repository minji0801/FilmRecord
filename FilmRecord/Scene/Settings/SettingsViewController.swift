//
//  SettingsViewController.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/14.
//  설정 화면

import SideMenu
import SnapKit
import UIKit

final class SettingsViewController: UIViewController {
    private lazy var presenter = SettingsPresenter(viewController: self)

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

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .insetGrouped)
        tableView.dataSource = presenter
        tableView.delegate = presenter

        tableView.register(
            SettingsTableViewCell.self,
            forCellReuseIdentifier: SettingsTableViewCell.identifier
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
}

// MARK: - SettingProtocol Function
extension SettingsViewController: SettingsProtocol {
    /// 네비게이션 바 구성
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.title = "settings"
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

        [tableView, coverView].forEach {
            view.addSubview($0)
        }

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        coverView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    /// 메뉴 화면 push
    func pushToMenuViewController() {
        coverView.isHidden = false
        let menuNavigationController = MenuNavigationController(rootViewController: MenuViewController())
        present(menuNavigationController, animated: true)
    }
}

// MARK: - @objc Function
extension SettingsViewController {

    /// 메뉴 버튼 클릭: 메뉴 화면 보여주기
    @objc func didTappedLeftBarButton() {
        presenter.didTappedLeftBarButton()
    }

    /// 메뉴 화면 사라지고 받는 노티
    @objc func didDismissMenuViewController(_ notification: Notification) {
        guard let object: Int = notification.object as? Int else { return }
        // 자기 자신 제외하고 컨트롤하기
        switch object {
        case 0:
            let homeViewContoller = HomeViewController()
            navigationController?.setViewControllers([homeViewContoller], animated: true)
        case 1:
            let calendarViewController = CalendarViewController()
            navigationController?.setViewControllers([calendarViewController], animated: true)
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

// MARK: - SideMenu
extension SettingsViewController: SideMenuNavigationControllerDelegate {

    /// 메뉴가 사라지려고 할 때
    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        coverView.isHidden = true
    }
}
