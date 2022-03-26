//
//  HomeViewController.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/25.
//  홈 화면

import UIKit

final class HomeViewController: UIViewController {
    private lazy var presenter = HomePresenter(viewController: self)

    private lazy var leftBarButtonItem: UIBarButtonItem = {
        let leftBarButtonItem = UIBarButtonItem()
        leftBarButtonItem.image = UIImage(systemName: "line.3.horizontal")

        return leftBarButtonItem
    }()

    private lazy var rightBarButtonItem: UIBarButtonItem = {
        let rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(didTappedRightBarButton)
        )

        return rightBarButtonItem
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }

    /// Right bar button was tapped.
    @objc func didTappedRightBarButton() {
        presenter.didTappedRightBarButton()
    }
}

// MARK: - HomeProtocol Function
extension HomeViewController: HomeProtocol {
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    func goToSearchMovieViewController() {
        let searchMovieViewController = MovieSearchViewController()
        navigationController?.pushViewController(searchMovieViewController, animated: true)
    }
}
