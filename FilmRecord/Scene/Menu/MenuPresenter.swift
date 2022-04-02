//
//  MenuPresenter.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/01.
//

import UIKit

protocol MenuProtocol: AnyObject {
    func setupNavigationBar()
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
        viewController?.setupNavigationBar()
        viewController?.setupView()
    }
}

// MARK: - UITableView
extension MenuPresenter: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView.tag {
        case 0: return 5
        case 1: return 3
        default: return 0
        }
    }

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