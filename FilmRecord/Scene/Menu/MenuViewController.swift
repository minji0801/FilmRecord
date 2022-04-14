//
//  MenuViewController.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/01.
//  메뉴 화면

import SnapKit
import UIKit

final class MenuViewController: UIViewController {
    private lazy var presenter = MenuPresenter(viewController: self)
    private lazy var userDefaultsManager = UserDefaultsManager()

    /// 메뉴 테이블 뷰
    private lazy var menuTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        tableView.tag = 0
        tableView.delegate = presenter
        tableView.dataSource = presenter

        tableView.register(
            MenuTableViewCell.self,
            forCellReuseIdentifier: MenuTableViewCell.identifier
        )

        return tableView
    }()

    /// 가로 스택 뷰: 작성한 리뷰 개수, 저작권
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill

        return stackView
    }()

    /// 작성한 리뷰 개수 라벨
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.font = FontManager().mediumFont()
        label.textColor = .label

        return label
    }()

    /// 저작권 라벨
    private lazy var copyrightLabel: UILabel = {
        let label = UILabel()
        label.text = "© Minji Kim"
        label.font = FontManager().mediumFont()
        label.textColor = .label

        return label
    }()

    /// 앱 테이블 뷰
    private lazy var appsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .secondarySystemBackground
        tableView.separatorStyle = .none
        tableView.tag = 1
        tableView.delegate = presenter
        tableView.dataSource = presenter

        tableView.register(
            AppsTableViewCell.self,
            forCellReuseIdentifier: AppsTableViewCell.identifier
        )

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
}

// MARK: - MenuProtocol Function
extension MenuViewController: MenuProtocol {
    /// 네비게이션 바 구성
    func setupNavigationBar() {
        navigationItem.title = "film record"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: FontManager().largeFont()
        ]
    }

    /// 뷰 구성
    func setupView() {
        view.backgroundColor = .systemBackground

        countLabel.text = "작성한 리뷰: \(userDefaultsManager.getReviews().count)"

        [menuTableView, horizontalStackView, appsTableView].forEach {
            view.addSubview($0)
        }

        [countLabel, copyrightLabel].forEach {
            horizontalStackView.addArrangedSubview($0)
        }

        menuTableView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(view.frame.height * 0.6)
        }

        horizontalStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16.0)
            $0.top.equalTo(menuTableView.snp.bottom)
            $0.height.equalTo(50)
        }

        appsTableView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(horizontalStackView.snp.bottom)
        }
    }

    /// 현재 뷰 닫기
    func dismiss() {
        dismiss(animated: true)
    }

    /// 메뉴 클릭: 해당 화면 push
    func didTappedMenu(_ row: Int) {
        NotificationCenter.default.post(name: NSNotification.Name("DismissMenu"), object: row)
    }

    /// 다른 앱 클릭: 해당 웹 페이지로 이동
    func didTappedApps(_ row: Int) {
        var url: URL!
        switch row {
        case 0:  url = URL(string: "https://apps.apple.com/kr/app/scoit/id1576850548")!
        case 1:  url = URL(string: "https://apps.apple.com/kr/app/%EB%AA%A8%EB%8B%A5%EC%9D%B4/id1596424726")!
        case 2:  url = URL(string: "https://apps.apple.com/kr/app/h-ours/id1605524722")!
        default: break
        }
        UIApplication.shared.open(url, options: [:])
    }
}
