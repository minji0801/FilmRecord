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

    func goToAppRating()
    func sendMail()
    func goToAppStore(_ appName: String)
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
    /// 섹션 수
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    /// 섹션 타이틀
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionHeader = [""]
        return sectionHeader[section]
    }

    /// 셀 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numRow = [7]
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

    /// 셀 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    /// 셀 선택 시
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case [0, 0]:
            viewController?.pushToDarkModeViewController()
        case [0, 1]:
            viewController?.pushToFontViewController()
        case [0, 2]:
            print("암호 잠금")
        case [0, 3]:
            print("터치/페이스 아이디")
//        case [0, 4]:
//            print("별점 남기기")
        case [0, 4]:
            viewController?.sendMail()
        case [0, 5]:
            print("이용 방법")
        case [1, 0]:
            viewController?.goToAppStore("Scoit")
        case [1, 1]:
            viewController?.goToAppStore("모닥이")
        case [1, 2]:
            viewController?.goToAppStore("h:ours")
        default:
            break
        }
    }
}
