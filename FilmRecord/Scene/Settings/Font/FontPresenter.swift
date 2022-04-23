//
//  FontPresenter.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/23.
//  글꼴 변경 Presenter

import Foundation
import UIKit

protocol FontProtocol: AnyObject {
    func setupAppearance()
    func setupNavigationBar()
    func setupView()
    func popViewController()
}

final class FontPresenter: NSObject {
    private weak var viewController: FontProtocol?

    init(viewController: FontProtocol?) {
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

// MARK: - UITableView
extension FontPresenter: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Font.allValues.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FontTableViewCell.identifier
        ) as? FontTableViewCell else { return UITableViewCell() }

        cell.update(indexPath.row)
        return cell
    }
}
