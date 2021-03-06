//
//  FavoriteViewController.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/03.
//  좋아하는 영화 화면

import SideMenu
import UIKit

final class FavoriteViewController: UIViewController {
    private lazy var presenter = FavoritePresenter(viewController: self)

    /// Left Bar Button: 메뉴 버튼
    private lazy var leftBarButtonItem: UIBarButtonItem = {
        let leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "line.3.horizontal"),
            style: .plain,
            target: self,
            action: #selector(didTappedLeftBarButton)
        )

        return leftBarButtonItem
    }()

    /// Right Bar Button
//    private lazy var rightBarButtonItem: UIBarButtonItem = {
//        let rightBarButtonItem = UIBarButtonItem(
//            image: UIImage(systemName: "plus"),
//            style: .plain,
//            target: self,
//            action: #selector(didTappedRightBarButton)
//        )
//
//        return rightBarButtonItem
//    }()

    /// Collection View
    private lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.dataSource = presenter
        collectionView.delegate = presenter

        collectionView.register(
            FavoriteCollectionViewCell.self,
            forCellWithReuseIdentifier: FavoriteCollectionViewCell.identifier
        )

        return collectionView
    }()

    /// 화면이 어두워지는  뷰
    private lazy var coverView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        view.isHidden = true

        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        presenter.viewWillAppear()
    }
}

extension FavoriteViewController: FavoriteProtocol {
    /// 화면 Appearance 설정
    func setupAppearance() {
        DarkModeManager.applyAppearance(mode: DarkModeManager.getAppearance(), viewController: self)
    }

    /// 네비게이션 바 구성
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = leftBarButtonItem
//        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.title = "좋아하는 영화"
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

        [collectionView, coverView].forEach {
            view.addSubview($0)
        }

        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        coverView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    /// 폰트 적용
    func applyFont() {
        let font = FontManager.getFont()

        navigationController?.navigationBar.titleTextAttributes = [
            .font: font.extraLargeFont
        ]
    }

    /// 메뉴 화면 push
    func pushToMenuViewController() {
        coverView.isHidden = false
        let menuNavigationController = MenuNavigationController(rootViewController: MenuViewController())
        present(menuNavigationController, animated: true)
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
}

// MARK: - @objc Function
extension FavoriteViewController {

    /// 메뉴 버튼 클릭: 메뉴 화면 보여주기
    @objc func didTappedLeftBarButton() {
        presenter.didTappedLeftBarButton()
    }

    /// + 버튼 클릭: 영화 검색 화면 보여주기
//    @objc func didTappedRightBarButton() {
//        presenter.didTappedRightBarButton()
//    }

    /// 메뉴 뷰 사라지고 받는 노티
    @objc func didDismissMenuViewController(_ notification: Notification) {
        guard let object: Int = notification.object as? Int else { return }
        // 자기 자신 제외하고 컨트롤하기
        switch object {
        case 0:
            let homeViewContoller = HomeViewController()
            navigationController?.setViewControllers([homeViewContoller], animated: true)
        case 1:
            let calendarViewController = CalendarViewController()
            navigationController?.setViewControllers([calendarViewController], animated: true)
        case 3:
            let toWatchViewController = ToWatchViewController()
            navigationController?.setViewControllers([toWatchViewController], animated: true)
        case 4:
            let settingsViewController = SettingsViewController()
            navigationController?.setViewControllers([settingsViewController], animated: true)
        default:
            break
        }
    }
}

// MARK: - SideMenu
extension FavoriteViewController: SideMenuNavigationControllerDelegate {

    /// 메뉴가 사라지려고 할 때
    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        coverView.isHidden = true
    }
}
