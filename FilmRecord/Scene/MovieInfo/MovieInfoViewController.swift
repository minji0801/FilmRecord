//
//  MovieInfoViewController.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/10.
//  영화 정보 화면

import SnapKit
import UIKit
import WebKit

final class MovieInfoViewController: UIViewController {
    private var presenter: MovieInfoPresenter!

    init(movie: Movie) {
        super.init(nibName: nil, bundle: nil)
        presenter = MovieInfoPresenter(viewController: self, movie: movie)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// left bar 버튼: 뒤로가기
    private lazy var leftBarButtonItem: UIBarButtonItem = {
        let leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrow.left"),
            style: .plain,
            target: self,
            action: #selector(didTappedLeftBarButton)
        )

        return leftBarButtonItem
    }()

    /// 영화 정보 웹뷰
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
}

// MARK: - MovieInfoProtocol
extension MovieInfoViewController: MovieInfoProtocol {
    /// 네비게이션 바 구성
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }

    /// 뷰 구성
    func setupView() {
        view.backgroundColor = .systemBackground

        view.addSubview(webView)

        webView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    /// 웹 뷰 구성
    func setupWebview(url: URL) {
        print(url)
        let request = URLRequest(url: url)
        webView.load(request)
    }

    /// 현재 뷰 pop
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - @objc Function
extension MovieInfoViewController {

    @objc func didTappedLeftBarButton() {
        presenter.didTappedLeftBarButton()
    }
}
