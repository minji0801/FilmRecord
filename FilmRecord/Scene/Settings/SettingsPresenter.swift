//
//  SettingsPresenter.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/14.
//  설정 Presenter

import Foundation
import UIKit

protocol SettingsProtocol: AnyObject {
    func setupAppearance()
    func setupNavigationBar()
    func setupNoti()
    func setupView()

    func reloadTableView()
    func pushToMenuViewController()

    func pushToDarkModeViewController()
    func pushToFontViewController()
    func pushToLockViewController()
    func goToAppRating()
    func sendMail()
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

    func viewWillAppear() {
        viewController?.setupAppearance()
        viewController?.reloadTableView()
    }

    func didTappedLeftBarButton() {
        viewController?.pushToMenuViewController()
    }
}

// MARK: - UITableView
extension SettingsPresenter: UITableViewDataSource, UITableViewDelegate {
    /// 셀 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    /// 셀 구성
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SettingsTableViewCell.identifier
        ) as? SettingsTableViewCell else { return UITableViewCell() }

        cell.update(indexPath: indexPath)

        return cell
    }

    /// 셀 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    /// 셀 선택 시
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            viewController?.pushToDarkModeViewController()
        case 1:
            viewController?.pushToFontViewController()
        case 2:
            viewController?.pushToLockViewController()
//        case 3:
//            print("별점 남기기")
        case 3:
            viewController?.sendMail()
        case 4:
            print("이용 방법")
        default:
            break
        }
    }
}
