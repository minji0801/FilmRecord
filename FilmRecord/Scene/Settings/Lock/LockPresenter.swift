//
//  LockPresenter.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/27.
//  암호 잠금 Presenter

import Foundation
import UIKit
protocol LockProtocol: AnyObject {
    func setupAppearance()
    func setupNavigationBar()
    func setupView()

    func applyFont()
    func popViewController()
}

final class LockPresenter: NSObject {
    private weak var viewController: LockProtocol?

    init(viewController: LockProtocol?) {
        self.viewController = viewController
    }

    func viewDidLoad() {
        viewController?.setupAppearance()
        viewController?.setupNavigationBar()
        viewController?.setupView()
        viewController?.applyFont()
    }

    func didTappedLeftBarButton() {
        viewController?.popViewController()
    }
}
