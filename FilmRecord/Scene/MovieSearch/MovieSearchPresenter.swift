//
//  MovieSearchPresenter.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/25.
//  영화 검색 Presenter

import Foundation
import UIKit

protocol MovieSearchProtocol: AnyObject {
    func setupAppearance()
    func setupNavigationBar()
    func setupView()

    func applyFont()
    func reloadCollectionView()
    func activeSearchController()
    func keyboardDown()
    func endRefreshing()
    func popViewController()
    func pushToEnterRatingViewController(movie: Movie)
}

final class MovieSearchPresenter: NSObject {
    private weak var viewController: MovieSearchProtocol?
    private let movieSearchManager: MovieSearchManagerProtocol
    private let userDefaultsManager: UserDefaultsManagerProtocol

    var movies: [Movie] = []
    private var fromHome: Bool

    private var currentKeyword = ""
    var currentPage: Int = 0
    var display: Int = 15

    init(
        viewController: MovieSearchProtocol,
        movieSearchManager: MovieSearchManagerProtocol = MovieSearchManager(),
        userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager(),
        fromHome: Bool
    ) {
        self.viewController = viewController
        self.movieSearchManager = movieSearchManager
        self.userDefaultsManager = userDefaultsManager
        self.fromHome = fromHome
    }

    func viewDidLoad() {
        viewController?.setupAppearance()
        viewController?.setupNavigationBar()
        viewController?.setupView()
    }

    func viewWillAppear() {
        viewController?.applyFont()
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
    /// 영화 검색
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            currentKeyword = searchText
            requestMovieList(isNeededToReset: true)
        }
    }

    /// 검색 바 보여졌을 때: 자동 포커싱
    func didPresentSearchController(_ searchController: UISearchController) {
        DispatchQueue.main.async {
            searchController.searchBar.becomeFirstResponder()
        }
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension MovieSearchPresenter: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    /// Cell 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    /// Cell 구성
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

    /// Cell 크기
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        print(collectionViewLayout)
        let inset: CGFloat = 16.0
        let spacing: CGFloat = 10.0
        let width: CGFloat = (collectionView.frame.width - (inset * 2) - (spacing * 2)) / 3
        return CGSize(width: width, height: width * 2)
    }

    /// CollectionView Inset 설정
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        let inset: CGFloat = 16.0
        return UIEdgeInsets(top: 0.0, left: inset, bottom: 0.0, right: inset)
    }

    /// 스크롤할 때 -> 키보드 내리기
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        viewController?.keyboardDown()
    }

    /// Cell 보여지려고 할 때 -> 다음 페이지 보여주기(페이징)
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        let currentRow = indexPath.row

        guard (currentPage * display) - currentRow == 3 else { return }

        requestMovieList(isNeededToReset: false)
    }

    /// Cell 선택 시
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

        movieSearchManager.request(
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
