//
//  HomeViewController.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/25.
//  홈 화면

import SideMenu
import SnapKit
import UIKit

final class HomeViewController: UIViewController {
    private lazy var presenter = HomePresenter(viewController: self)

    private lazy var leftBarButtonItem: UIBarButtonItem = {
        let leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "line.3.horizontal"),
            style: .plain,
            target: self,
            action: #selector(didTappedLeftBarButton)
        )

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

    private lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = presenter
        collectionView.delegate = presenter

        collectionView.register(
            HomeCollectionViewCell.self,
            forCellWithReuseIdentifier: HomeCollectionViewCell.identifier
        )

        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
        // 폰트 체크 하기
        UIFont.familyNames.sorted().forEach { familyName in
            print("*** \(familyName) ***")
            UIFont.fontNames(forFamilyName: familyName).forEach { fontName in
                print("\(fontName)")
            }
            print("---------------------")
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
}

// MARK: - HomeProtocol Function
extension HomeViewController: HomeProtocol {
    /// 네비게이션 바 구성
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
//        navigationItem.title = "Film Record"
//        navigationController?.navigationBar.titleTextAttributes = [
//            NSAttributedString.Key.font: FontManager().largeFont()
//        ]
    }

    /// 노티피케이션 구성
    func setupNoti() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didDismissMenuViewController(_:)),
            name: NSNotification.Name("DismissMenu"),
            object: nil
        )
    }

    /// 뷰 구성
    func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)

        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    /// 메뉴 화면 push
    func pushToMenuViewController() {
        let menuNavigationController = MenuNavigationController(rootViewController: MenuViewController())
        present(menuNavigationController, animated: true)
    }

    /// 영화 검색 화면 push
    func pushToSearchMovieViewController() {
        let searchMovieViewController = MovieSearchViewController(movieSearchDelegate: presenter)
        navigationController?.pushViewController(searchMovieViewController, animated: true)
    }

    /// CollectionView Reload
    func reloadCollectionView() {
        collectionView.reloadData()
    }

    /// 리뷰 상세 화면 push
    func pushToDetailViewController(review: Review) {
        let detailViewController = DetailViewController(review: review)
        navigationController?.pushViewController(detailViewController, animated: true)
    }

    /// 평점 입력 화면 보여주기
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
extension HomeViewController {

    @objc func didTappedLeftBarButton() {
        presenter.didTappedLeftBarButton()
    }

    @objc func didTappedRightBarButton() {
        presenter.didTappedRightBarButton()
    }

    /// 메뉴 뷰 사라지고 받는 노티
    @objc func didDismissMenuViewController(_ notification: Notification) {
        guard let object: Int = notification.object as? Int else { return }
        // 자기 자신 제외하고 컨트롤하기
        switch object {
//        case 2:
//            let favoriteListViewController = FavoriteListViewController()
//            navigationController?.pushViewController(favoriteListViewController, animated: true)
        case 3:
            let toWatchViewController = ToWatchViewController()
            navigationController?.setViewControllers([toWatchViewController], animated: true)
        default:
            break
        }
    }
}
