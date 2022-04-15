//
//  SettingsPresenter.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/14.
//  설정 Presenter

import Foundation
import UIKit

protocol SettingsProtocol: AnyObject {
    func setupNavigationBar()
    func setupNoti()
    func setupView()

    func pushToMenuViewController()
}

final class SettingsPresenter: NSObject {
    private weak var viewController: SettingsProtocol?

    init(viewController: SettingsProtocol?) {
        self.viewController = viewController
    }

    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupNoti()
        viewController?.setupView()
    }

    func didTappedLeftBarButton() {
        viewController?.pushToMenuViewController()
    }
}

// MARK: - UITableView
extension SettingsPresenter: UITableViewDataSource, UITableViewDelegate {
    /// 섹션 수
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    /// 섹션 타이틀
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionHeader = ["디스플레이", "잠금", "지원", "ⓒ Minji Kim"]
        return sectionHeader[section]
    }

    /// 셀 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numRow = [2, 2, 4, 3]
        return numRow[section]
    }

    /// 셀 구성
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SettingsTableViewCell.identifier
        ) as? SettingsTableViewCell else { return UITableViewCell() }

        cell.update(indexPath: indexPath)

        return cell
    }
}
