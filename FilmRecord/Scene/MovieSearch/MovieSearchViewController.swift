//
//  MovieSearchViewController.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/25.
//  영화 검색 화면

import SnapKit
import UIKit

final class MovieSearchViewController: UIViewController {
    private lazy var presenter = MovieSearchPresenter(viewController: self)

    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "영화 검색"
        searchController.searchBar.keyboardType = .default
        searchController.searchBar.autocorrectionType = .no
        searchController.searchBar.spellCheckingType = .no
        searchController.searchBar.autocapitalizationType = .none
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.showsCancelButton = false
        searchController.searchBar.delegate = presenter
        searchController.delegate = presenter

        return searchController
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = presenter
        collectionView.delegate = presenter

        collectionView.register(
            MovieSearchCollectionViewCell.self,
            forCellWithReuseIdentifier: MovieSearchCollectionViewCell.identifier
        )

        collectionView.refreshControl = refreshControl
        return collectionView
    }()

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        presenter.viewDidAppear()
    }

    @objc func pullToRefresh() {
        presenter.pullToRefresh()
    }
}

// MARK: - SearchMovieProtocol Function
extension MovieSearchViewController: MovieSearchProtocol {
    func setupNavigationBar() {
        navigationController?.navigationBar.topItem?.title = ""
        navigationItem.titleView = searchController.searchBar
    }

    func setupView() {
        view.addSubview(collectionView)

        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func reloadCollectionView() {
        collectionView.reloadData()
    }

    func activeSearchController() {
        searchController.isActive = true
    }

    func keyboardDown() {
        searchController.searchBar.endEditing(true)
    }

    func endRefreshing() {
        refreshControl.endRefreshing()
    }
}
