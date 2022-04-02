//
//  MovieSearchPresenter.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/25.
//  영화 검색 Presenter

import Foundation
import UIKit

protocol MovieSearchProtocol: AnyObject {
    func setupNavigationBar()
    func setupView()
    func reloadCollectionView()
    func activeSearchController()
    func keyboardDown()
    func endRefreshing()
    func popViewController()
    func pushToEnterRatingViewController(movie: Movie)
}

final class MovieSearchPresenter: NSObject {
    private weak var viewController: MovieSearchProtocol?
    private let searchMovieManager: MovieSearchManagerProtocol
    private let userDefaultsManager: UserDefaultsManagerProtocol

    private var movies: [Movie] = []
    private var fromHome: Bool

    private var currentKeyword = ""
    private var currentPage: Int = 0
    private let display: Int = 15

    init(
        viewController: MovieSearchProtocol,
        searchMovieManager: MovieSearchManagerProtocol = MovieSearchManager(),
        userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager(),
        fromHome: Bool
    ) {
        self.viewController = viewController
        self.searchMovieManager = searchMovieManager
        self.userDefaultsManager = userDefaultsManager
        self.fromHome = fromHome
    }

    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupView()
    }

    func viewDidAppear() {
        viewController?.activeSearchController()
    }

    func pullToRefresh() {
        requestMovieList(isNeededToReset: true)
    }

    func didTappedLeftBarButton() {
        viewController?.popViewController()
    }
}

// MARK: - UISearchBarDelegate, UISearchControllerDelegate
extension MovieSearchPresenter: UISearchBarDelegate, UISearchControllerDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        currentKeyword = searchText
        requestMovieList(isNeededToReset: true)
    }

    func didPresentSearchController(_ searchController: UISearchController) {
        DispatchQueue.main.async {
            searchController.searchBar.becomeFirstResponder()
        }
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension MovieSearchPresenter: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieSearchCollectionViewCell.identifier,
            for: indexPath
        ) as? MovieSearchCollectionViewCell else { return UICollectionViewCell() }

        cell.update(movie: movies[indexPath.row])
        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let inset: CGFloat = 16.0
        let spacing: CGFloat = 10.0
        let width: CGFloat = (collectionView.frame.width - (inset * 2) - (spacing * 2)) / 3
        return CGSize(width: width, height: width * 2)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        let inset: CGFloat = 16.0
        return UIEdgeInsets(top: 0.0, left: inset, bottom: 0.0, right: inset)
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        viewController?.keyboardDown()
    }

    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        let currentRow = indexPath.row

        guard (currentPage * display) - currentRow == 3 else { return }

        requestMovieList(isNeededToReset: false)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        if fromHome {
            // Home에서 왔을 때: 선택한 영화 평점 입력 화면으로 넘겨주기
            viewController?.pushToEnterRatingViewController(movie: movie)
        } else {
            // 보고싶은 영화에서 왔을 떄: 선택한 영화 UserDefaults에 저장하고 pop하기
            userDefaultsManager.setMovieToWatch(Watch(movie: movie, watched: false))
            viewController?.popViewController()
        }
    }
}

private extension MovieSearchPresenter {
    func requestMovieList(isNeededToReset: Bool) {
        if isNeededToReset {
            currentPage = 0
            movies = []
        }

        searchMovieManager.request(
            from: currentKeyword,
            start: (currentPage * display) + 1,
            display: display
        ) { [weak self] newValue in
            guard let self = self else { return }

            self.movies += newValue
            self.currentPage += 1
            self.viewController?.reloadCollectionView()
            self.viewController?.endRefreshing()
        }
    }
}
