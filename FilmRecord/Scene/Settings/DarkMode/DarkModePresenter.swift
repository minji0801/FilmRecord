//
//  DarkModePresenter.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/18.
//  Appearance 변경 Presenter

import Foundation
import UIKit

protocol DarkModeProtocol: AnyObject {
    func setupAppearance()
    func setupNavigationBar()
    func setupView()

    func popViewController()
    func tableViewReload()
}

final class DarkModePresenter: NSObject {
    private weak var viewController: DarkModeProtocol?

    init(viewController: DarkModeProtocol?) {
        self.viewController = viewController
    }

    func viewDidLoad() {
        viewController?.setupAppearance()
        viewController?.setupNavigationBar()
        viewController?.setupView()
    }

    func didTappedLeftBarButton() {
        viewController?.popViewController()
    }
}

extension DarkModePresenter: UITableViewDataSource, UITableViewDelegate {
    /// 행 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    /// 셀 구성
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: DarkModeTableViewCell.identifier
        ) as? DarkModeTableViewCell else { return UITableViewCell() }

        cell.update(indexPath.row, DarkModeManager.getAppearance())

        return cell
    }

    /// 셀 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    /// 셀 클릭
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        if row == 0 {
            DarkModeManager.setApperance(mode: .light)
        } else {
            DarkModeManager.setApperance(mode: .dark)
        }

        viewController?.setupAppearance()
        viewController?.tableViewReload()
    }
}
