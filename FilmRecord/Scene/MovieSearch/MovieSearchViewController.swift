//
//  MovieSearchViewController.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/25.
//  영화 검색 화면

import SnapKit
import UIKit

final class MovieSearchViewController: UIViewController {
    private var presenter: MovieSearchPresenter!

    init(fromHome: Bool) {
        super.init(nibName: nil, bundle: nil)
        presenter = MovieSearchPresenter(viewController: self, fromHome: fromHome)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var leftBarButtonItem: UIBarButtonItem = {
        let leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrow.left"),
            style: .plain,
            target: self,
            action: #selector(didTappedLeftBarButton)
        )

        return leftBarButtonItem
    }()

    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "제목을 입력해주세요."

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
        collectionView.backgroundColor = .secondarySystemBackground
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        presenter.viewWillAppear()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        presenter.viewDidAppear()
    }
}

// MARK: - SearchMovieProtocol Function
extension MovieSearchViewController: MovieSearchProtocol {
    /// 화면 Appearance 설정
    func setupAppearance() {
        DarkModeManager.applyAppearance(mode: DarkModeManager.getAppearance(), viewController: self)
    }

    /// 네비게이션 바 구성
    func setupNavigationBar() {
        navigationItem.title = "영화 검색"
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.searchController = searchController
    }

    /// 뷰 구성
    func setupView() {
        definesPresentationContext = true   // 다른 VC을 push해도 최상단에 UISearchController가 있지 않도록!

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(didTappedLeftBarButton))
        view.addGestureRecognizer(swipeLeft)

        view.addSubview(collectionView)

        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    /// 폰트 적용
    func applyFont() {
        let font = FontManager.getFont()

        navigationController?.navigationBar.titleTextAttributes = [
            .font: font.extraLargeFont
        ]
        searchController.searchBar.searchTextField.font = font.largeFont

    }

    /// 콜렉션 뷰 다시 로드
    func reloadCollectionView() {
        collectionView.reloadData()
    }

    /// 검색창 활성화
    func activeSearchController() {
        searchController.isActive = true
    }

    /// 키보드 내리기
    func keyboardDown() {
        searchController.searchBar.endEditing(true)
    }

    /// 새로고침 종료
    func endRefreshing() {
        refreshControl.endRefreshing()
    }

    /// 현재 뷰 pop
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }

    /// 평점 입력 화면 push
    func pushToEnterRatingViewController(movie: Movie) {
        let enterRagingViewController = EnterRatingViewController(
            movie: movie,
            review: Review.EMPTY,
            isEditing: false
        )
        navigationController?.pushViewController(enterRagingViewController, animated: true)
    }
}

// MARK: - @objc Function
extension MovieSearchViewController {

    @objc func didTappedLeftBarButton() {
        presenter.didTappedLeftBarButton()
    }

    @objc func pullToRefresh() {
        presenter.pullToRefresh()
    }
}
