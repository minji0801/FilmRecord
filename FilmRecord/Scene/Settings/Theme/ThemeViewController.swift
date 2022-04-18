//
//  ThemeViewcontroller.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/18.
//  테마 변경 화면

import Foundation
import SnapKit
import UIKit

final class ThemeViewController: UIViewController {
    private lazy var presenter = ThemePresenter(viewController: self)

    /// Left Bar Button: 뒤로가기 버튼
    private lazy var leftBarButtonItem: UIBarButtonItem = {
        let leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrow.left"),
            style: .plain,
            target: self,
            action: #selector(didTappedLeftBarButton)
        )

        return leftBarButtonItem
    }()

    /// 테이블 뷰
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.dataSource = presenter
        tableView.delegate = presenter

        tableView.register(
            ThemeTableViewCell.self,
            forCellReuseIdentifier: ThemeTableViewCell.identifier
        )

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
}

// MARK: - ThemeProtocol Function
extension ThemeViewController: ThemeProtocol {
    /// 네비게이션 바 구성
    func setupNavigationBar() {
        navigationItem.title = "다크 모드"
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }

    /// 뷰 구성
    func setupView() {
        view.backgroundColor = .systemBackground

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(didTappedLeftBarButton))
        view.addGestureRecognizer(swipeLeft)

        view.addSubview(tableView)

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    /// 현재 뷰 pop
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - @objc Function
extension ThemeViewController {
    /// 뒤로 가기 버튼 클릭
    @objc func didTappedLeftBarButton() {
        presenter.didTappedLeftBarButton()
    }
}