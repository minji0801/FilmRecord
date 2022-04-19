//
//  MenuPresenter.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/01.
//  메뉴 화면 Presenter

import UIKit

protocol MenuProtocol: AnyObject {
    func setupAppearance()
    func setupView()

    func dismiss()
    func didTappedMenu(_ row: Int)
    func didTappedApps(_ row: Int)
}

final class MenuPresenter: NSObject {
    private weak var viewController: MenuProtocol?

    init(viewController: MenuProtocol?) {
        self.viewController = viewController
    }

    func viewDidLoad() {
        viewController?.setupAppearance()
        viewController?.setupView()
    }
}

// MARK: - UITableView
extension MenuPresenter: UITableViewDelegate, UITableViewDataSource {
    /// Row 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView.tag {
        case 0: return 5
        case 1: return 3
        default: return 0
        }
    }

    /// Cell 구성
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView.tag {
        case 0:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: MenuTableViewCell.identifier,
                for: indexPath
            ) as? MenuTableViewCell else { return UITableViewCell() }
            cell.setupCell(row: indexPath.row)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: AppsTableViewCell.identifier,
                for: indexPath
            ) as? AppsTableViewCell else { return UITableViewCell() }
            cell.setupCell(row: indexPath.row)
            return cell
        default: return UITableViewCell()
        }
    }

    /// Cell 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    /// Cell 선택 시
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewController?.dismiss()
        switch tableView.tag {
        case 0:
            viewController?.didTappedMenu(indexPath.row)
        case 1:
            viewController?.didTappedApps(indexPath.row)
        default: break
        }
    }
}
