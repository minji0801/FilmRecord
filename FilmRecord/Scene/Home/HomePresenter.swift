//
//  HomePresenter.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/25.
//  홈 Presenter

import Foundation

protocol HomeProtocol: AnyObject {
    func setupNavigationBar()
    func goToSearchMovieViewController()
}

final class HomePresenter: NSObject {
    private let viewController: HomeProtocol?

    init(viewController: HomeProtocol) {
        self.viewController = viewController
    }

    func viewDidLoad() {
        viewController?.setupNavigationBar()
    }

    func didTappedRightBarButton() {
        viewController?.goToSearchMovieViewController()
    }
}
