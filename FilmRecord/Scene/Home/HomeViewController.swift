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
        let rightBarButtonItem = UIBarButtonItem()
        rightBarButtonItem.image = UIImage(systemName: "plus")
        return rightBarButtonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
}

extension HomeViewController: HomeProtocol {
    func setupNavigationBar() {
        navigationItem.title = "Film Record"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
}
