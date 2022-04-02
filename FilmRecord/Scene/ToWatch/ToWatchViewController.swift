//
//  ToWatchViewController.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/02.
//  보고 싶은 영화 화면

import SnapKit
import UIKit

final class ToWatchViewController: UIViewController {
    private lazy var presenter = ToWatchPresenter(viewController: self)

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

    /// Right Bar Button: 영화 검색 버튼
    private lazy var rightBarButtonItem: UIBarButtonItem = {
        let rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(didTappedRightBarButton)
        )

        return rightBarButtonItem
    }()

    /// Table View
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = presenter
        tableView.delegate = presenter

        tableView.register(
            ToWatchTableViewCell.self,
            forCellReuseIdentifier: ToWatchTableViewCell.identifier
        )

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        presenter.viewWillAppear()
    }
}

// MARK: - ToWatchProtocol Function
extension ToWatchViewController: ToWatchProtocol {
    /// 네비게이션 바 구성
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.title = "to-watch list"
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
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didSelectedMovie),
            name: NSNotification.Name("SelectedMovie"),
            object: nil
        )
    }

    /// 뷰 구성
    func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    /// 메뉴 화면 push
    func pushToMenuViewController() {
        let menuNavigationController = MenuNavigationController(rootViewController: MenuViewController())
        present(menuNavigationController, animated: true)
    }

    /// 영화 검색 화면 push
    func pushToSearchMovieViewController() {
        let searchMovieViewController = MovieSearchViewController(movieSearchDelegate: presenter)
        navigationController?.pushViewController(searchMovieViewController, animated: true)
    }

    /// 테이블 뷰 다시 로드하기
    func reloadTableView() {
        tableView.reloadData()
    }
}

// MARK: - @objc Function
extension ToWatchViewController {

    /// 메뉴 버튼 클릭: 메뉴 화면 보여주기
    @objc func didTappedLeftBarButton() {
        presenter.didTappedLeftBarButton()
    }

    /// + 버튼 클릭: 영화 검색 화면 보여주기
    @objc func didTappedRightBarButton() {
        presenter.didTappedRightBarButton()
    }

    /// 영화 검색 화면에서 영화 선택 후 받는 노티
    @objc func didSelectedMovie() {
        presenter.didSelectedMovie()
    }

    /// 메뉴 뷰 사라지고 받는 노티
    @objc func didDismissMenuViewController(_ notification: Notification) {
        guard let object: Int = notification.object as? Int else { return }
        // 자기 자신 제외하고 컨트롤하기
        switch object {
        case 0:
            let homeViewContoller = HomeViewController()
            navigationController?.setViewControllers([homeViewContoller], animated: true)
            //        case 2:
            //            let favoriteListViewController = FavoriteListViewController()
            //            navigationController?.pushViewController(favoriteListViewController, animated: true)
        default:
            break
        }
    }
}