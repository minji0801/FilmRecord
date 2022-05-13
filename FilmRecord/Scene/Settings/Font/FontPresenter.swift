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

    func applyFont()
    func reloadTableView()
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

    func viewWillAppear() {
        viewController?.applyFont()
        viewController?.reloadTableView()
    }

    func didTappedLeftBarButton() {
        viewController?.popViewController()
    }
}

// MARK: - UITableView
extension FontPresenter: UITableViewDataSource, UITableViewDelegate {

    /// 행 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Font.allValues.count
    }

    /// 셀 구성
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FontTableViewCell.identifier
        ) as? FontTableViewCell else { return UITableViewCell() }

        let font = FontManager.getFont()
        let selected = indexPath.row == font.rawValue ? true : false
        cell.update(indexPath.row, selected)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    /// 셀 클릭
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        FontManager.setFont(font: Font(rawValue: indexPath.row)!)
        viewWillAppear()
    }
}
