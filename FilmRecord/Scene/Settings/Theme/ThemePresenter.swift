//
//  ThemePresenter.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/18.
//  테마 변경 Presenter

import Foundation
import UIKit

protocol ThemeProtocol: AnyObject {
    func setupNavigationBar()
    func setupView()
    func popViewController()
}

final class ThemePresenter: NSObject {
    private weak var viewController: ThemeProtocol?

    init(viewController: ThemeProtocol?) {
        self.viewController = viewController
    }

    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupView()
    }

    func didTappedLeftBarButton() {
        viewController?.popViewController()
    }
}

extension ThemePresenter: UITableViewDataSource, UITableViewDelegate {
    /// 행 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    /// 셀 구성
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ThemeTableViewCell.identifier
        ) as? ThemeTableViewCell else { return UITableViewCell() }

        cell.update(indexPath.row)

        return cell
    }

    /// 셀 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
