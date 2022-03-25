//
//  SearchMoviePresenter.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/25.
//  영화 검색 Presenter

import Foundation
import UIKit

protocol SearchMovieProtocol: AnyObject {
    func setupNavigationBar()
    func setupView()
    func reloadCollectionView()
    func activeSearchController()
    func keyboardDown()
}

final class SearchMoviePresenter: NSObject {
    private weak var viewController: SearchMovieProtocol?
    private let searchMovieManager: SearchMovieManagerProtocol

    private var movies: [Movie] = []

    init(
        viewController: SearchMovieProtocol,
        searchMovieManager: SearchMovieManagerProtocol = SearchMovieManager()
    ) {
        self.viewController = viewController
        self.searchMovieManager = searchMovieManager
    }

    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupView()
    }

    func viewDidAppear() {
        viewController?.activeSearchController()
    }
}

// MARK: - UISearchBarDelegate, UISearchControllerDelegate
extension SearchMoviePresenter: UISearchBarDelegate, UISearchControllerDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }

        searchMovieManager.request(from: searchText) { [weak self] movies in
            guard let self = self else { return }
            self.movies = movies
            self.viewController?.reloadCollectionView()
        }
    }

    func didPresentSearchController(_ searchController: UISearchController) {
        DispatchQueue.main.async {
            searchController.searchBar.becomeFirstResponder()
        }
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension SearchMoviePresenter: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SearchMovieCollectionViewCell.identifier,
            for: indexPath
        ) as? SearchMovieCollectionViewCell else { return UICollectionViewCell() }

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
        return CGSize(width: width, height: width * 2.2)
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
}
