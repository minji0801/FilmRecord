//
//  HomePresenter.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/25.
//

import Foundation

protocol HomeProtocol: AnyObject {
    func setupNavigationBar()
}

final class HomePresenter: NSObject {
    private let viewController: HomeProtocol?

    init(viewController: HomeProtocol) {
        self.viewController = viewController
    }

    func viewDidLoad() {
        viewController?.setupNavigationBar()
    }
}
