//
//  ToWatchPresenter.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/02.
//

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

    private var movies: [Watch] = []
    private var watch: Watch = Watch.EMPTY

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
    }

    func didTappedLeftBarButton() {
        viewController?.pushToMenuViewController()
    }

    func didTappedRightBarButton() {
        viewController?.pushToSearchMovieViewController()
    }

    /// 영화 선택하고 나서
    func didDismissSearchViewController() {
        // UserDefaults 내용 업데이트하기
        movies = userDefaultsManager.getMovieToWatch()
        print("보고 싶은 영화: \(movies)")
        viewController?.reloadTableView()
    }
}

// MARK: - SearchMovieDelegate
extension ToWatchPresenter: MovieSearchDelegate {
    /// 영화 검색 화면에서 선택한 영화 정보를 UserDefaults에 저장하고 TableView reload하기
    func selectMovie(_ movie: Movie) {
        let watch = Watch(movie: movie, watched: false)
        userDefaultsManager.setMovieToWatch(watch)

        // TableView로 Noti 보내기
        NotificationCenter.default.post(name: NSNotification.Name("DismissSearchView"), object: nil)
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

        deleteAction.image = UIImage(named: "delete")
        deleteAction.image?.withTintColor(.white)
        deleteAction.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}
