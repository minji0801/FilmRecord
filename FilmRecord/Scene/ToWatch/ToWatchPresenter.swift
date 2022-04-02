//
//  ToWatchPresenter.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/02.
//  보고 싶은 영화 Presenter

import UIKit

protocol ToWatchProtocol: AnyObject {
    func setupNavigationBar()
    func setupNoti()
    func setupView()
    func pushToMenuViewController()
    func pushToSearchMovieViewController()
    func reloadTableView()
}

final class ToWatchPresenter: NSObject {
    private weak var viewController: ToWatchProtocol?
    private let userDefaultsManager: UserDefaultsManagerProtocol

    private var movies: [Watch] = []        // 보고 싶은 영화들
    private var watch: Watch = Watch.EMPTY  // 영화 검색 화면에서 선택한 영화

    init(
        viewController: ToWatchProtocol?,
        userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager()
    ) {
        self.viewController = viewController
        self.userDefaultsManager = userDefaultsManager
    }

    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupNoti()
        viewController?.setupView()
    }

    func viewWillAppear() {
        movies = userDefaultsManager.getMovieToWatch()
        print("보고 싶은 영화: \(movies)")
        viewController?.reloadTableView()
    }

    func didTappedLeftBarButton() {
        viewController?.pushToMenuViewController()
    }

    func didTappedRightBarButton() {
        viewController?.pushToSearchMovieViewController()
    }
}

// MARK: - UITableView
extension ToWatchPresenter: UITableViewDataSource, UITableViewDelegate {
    /// Cell 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    /// Cell 구성
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ToWatchTableViewCell.identifier,
            for: indexPath
        ) as? ToWatchTableViewCell else { return UITableViewCell() }

        let movie = movies[indexPath.row]
        cell.update(movie)
        return cell
    }

    /// Cell 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }

    /// Cell 클릭: watched 변경 (체크마크 표시)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var movie = movies[indexPath.row]
        movie.watched = !movie.watched
        movies[indexPath.row] = movie

        print("보고 싶은 영화: \(movies)")
        userDefaultsManager.overwriteToWatch(movies)
        viewController?.reloadTableView()
    }

    /// Cell 삭제
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] _, _, _ in
            guard let self = self else { return }

            self.movies.remove(at: indexPath.row)
            self.userDefaultsManager.overwriteToWatch(self.movies)    // UserDefaults에 덮어쓰기

            tableView.deleteRows(at: [indexPath], with: .automatic) // 테이블 행 제거
        }

        deleteAction.image = UIImage(systemName: "trash.fill")
        deleteAction.image?.withTintColor(.white)
        deleteAction.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}
