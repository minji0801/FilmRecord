//
//  ThemePresenter.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/18.
//  테마 변경 Presenter

import Foundation

protocol ThemeProtocol: AnyObject {
    func setupNavigationBar()
    func setupView()
    func popViewController()
}

final class ThemePresenter: NSObject {
    private weak var viewController: ThemeProtocol?

    init(viewController: ThemeProtocol?) {
        self.viewController = viewController
    }

    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupView()
    }

    func didTappedLeftBarButton() {
        viewController?.popViewController()
    }
}
