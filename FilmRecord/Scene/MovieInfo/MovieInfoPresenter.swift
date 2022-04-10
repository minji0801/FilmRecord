//
//  MovieInfoPresenter.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/10.
//  영화 정보 presenter

import Foundation

protocol MovieInfoProtocol: AnyObject {
    func setupNavigationBar()
    func setupView()
    func setupWebview(url: URL)

    func popViewController()
}

final class MovieInfoPresenter: NSObject {
    private weak var viewController: MovieInfoProtocol?

    private var movie: Movie

    init(
        viewController: MovieInfoProtocol?,
        movie: Movie
    ) {
        self.viewController = viewController
        self.movie = movie
    }

    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupView()

        if let url = URL(string: movie.link) {
            viewController?.setupWebview(url: url)
        }
    }

    func didTappedLeftBarButton() {
        viewController?.popViewController()
    }
}
