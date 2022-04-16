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
        let numRow = [2, 2, 3, 3]
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

    /// 셀 선택 시
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case [0, 0]:
            print("테마 변경")
        case [0, 1]:
            print("글꼴 변경")
        case [1, 0]:
            print("암호 잠금")
        case [1, 1]:
            print("터치/페이스 아이디")
//        case [2, 0]:
//            print("별점 남기기")
        case [2, 0]:
            viewController?.sendMail()
        case [2, 1]:
            print("이용 방법")
        case [3, 0]:
            print("스코잇")
        case [3, 1]:
            print("h:ours")
        case [3, 2]:
            print("모닥이")
        default:
            break
        }
    }
}
