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
    }

    func didTappedLeftBarButton() {
        viewController?.popViewController()
    }
}

// MARK: - UITableView
extension FontPresenter: UITableViewDataSource, UITableViewDelegate {
    /// 섹션 타이틀
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "글씨체"
    }

    /// 행 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Font.allValues.count
    }

    /// 셀 구성
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FontTableViewCell.identifier
        ) as? FontTableViewCell else { return UITableViewCell() }

        cell.update(indexPath.row)
        return cell
    }

    /// 셀 클릭
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        FontManager.setFont(font: Font(rawValue: indexPath.row)!)
        viewWillAppear()
    }
}
