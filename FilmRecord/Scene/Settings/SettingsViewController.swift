//
//  SettingsViewController.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/14.
//  설정 화면

import MessageUI
import SideMenu
import SnapKit
import UIKit

final class SettingsViewController: UIViewController {
    private lazy var presenter = SettingsPresenter(viewController: self)

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

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .secondarySystemBackground
        tableView.separatorStyle = .none
        tableView.dataSource = presenter
        tableView.delegate = presenter

        tableView.register(
            SettingsTableViewCell.self,
            forCellReuseIdentifier: SettingsTableViewCell.identifier
        )

        return tableView
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

// MARK: - SettingProtocol Function
extension SettingsViewController: SettingsProtocol {
    /// 화면 Appearance 설정
    func setupAppearance() {
        DarkModeManager.applyAppearance(mode: DarkModeManager.getAppearance(), viewController: self)
    }

    /// 네비게이션 바 구성
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.title = "설정"
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
        [tableView, coverView].forEach {
            view.addSubview($0)
        }

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        coverView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    /// 테이블 뷰 다시 불러오기
    func reloadTableView() {
        tableView.reloadData()
    }

    /// 메뉴 화면 push
    func pushToMenuViewController() {
        coverView.isHidden = false
        let menuNavigationController = MenuNavigationController(rootViewController: MenuViewController())
        present(menuNavigationController, animated: true)
    }

    /// 다크 모드 화면 push
    func pushToDarkModeViewController() {
        let darkModeViewController = DarkModeViewController()
        navigationController?.pushViewController(darkModeViewController, animated: true)
    }

    /// 글꼴  화면 push
    func pushToFontViewController() {
        let fontViewController = FontViewController()
        navigationController?.pushViewController(fontViewController, animated: true)
    }

    /// 암호 잠금 화면 push
    func pushToLockViewController() {
        let lockViewController = LockViewController()
        navigationController?.pushViewController(lockViewController, animated: true)
    }

    /// 별점 남기기: 앱스토어 리뷰 화면으로 이동
    func goToAppRating() {
        let store = ""
        if let url = URL(string: store), UIApplication.shared.canOpenURL(url) {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            components?.queryItems =  [URLQueryItem(name: "action", value: "write-review")]

            guard let writeReviewURL = components?.url else { return }

            if #available(iOS 10.0, *) {
                UIApplication.shared.open(writeReviewURL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(writeReviewURL)
            }
        }
    }

    /// 의견 보내기: 메일 보내기
    func sendMail() {
        if MFMailComposeViewController.canSendMail() {
            let composeViewController = MFMailComposeViewController()
            composeViewController.overrideUserInterfaceStyle = DarkModeManager.getAppearance().rawValue == 0 ? .light : .dark
            composeViewController.mailComposeDelegate = self
            composeViewController.setToRecipients(["앱 이름.help@gmail.com"])   // TODO: 앱 이름 넣기
            composeViewController.setSubject("<앱 이름> 문의 및 의견")
            composeViewController.setMessageBody(commentsBodyString(), isHTML: false)
            composeViewController.modalPresentationStyle = .fullScreen
            present(composeViewController, animated: true)
        } else {
            let sendMailFailAlertViewController = SendMailFailAlertViewController()
            sendMailFailAlertViewController.modalPresentationStyle = .overCurrentContext
            present(sendMailFailAlertViewController, animated: false)
        }
    }

    // TODO: 이용 방법
}

// MARK: - Etc. Function
private extension SettingsViewController {
    /// 의견 보내기: 내용
    func commentsBodyString() -> String {
        return """
                이곳에 내용을 작성해주세요.


                -------------------

                Device Model : \(getDeviceIdentifier())
                Device OS : \(UIDevice.current.systemVersion)
                App Version : \(getCurrentVersion())

                -------------------
                """
    }

    /// 현재 버전 가져오기
    func getCurrentVersion() -> String {
        guard let dictionary = Bundle.main.infoDictionary,
              let version = dictionary["CFBundleShortVersionString"] as? String else { return "" }
        return version
    }

    /// 기기 Identifier 찾기
    func getDeviceIdentifier() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
}

// MARK: - @objc Function
extension SettingsViewController {

    /// 메뉴 버튼 클릭: 메뉴 화면 보여주기
    @objc func didTappedLeftBarButton() {
        presenter.didTappedLeftBarButton()
    }

    /// 메뉴 화면 사라지고 받는 노티
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
        case 2:
            let favoriteViewController = FavoriteViewController()
            navigationController?.setViewControllers([favoriteViewController], animated: true)
        case 3:
            let toWatchViewController = ToWatchViewController()
            navigationController?.setViewControllers([toWatchViewController], animated: true)
        default:
            break
        }
    }
}

// MARK: - SideMenu
extension SettingsViewController: SideMenuNavigationControllerDelegate {

    /// 메뉴가 사라지려고 할 때
    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        coverView.isHidden = true
    }
}

// MARK: - MailComposeViewController Delegate
extension SettingsViewController: MFMailComposeViewControllerDelegate {
    /// (의견 보내기) 메일 보낸 후
    func mailComposeController(
        _ controller: MFMailComposeViewController,
        didFinishWith result: MFMailComposeResult,
        error: Error?
    ) {
        dismiss(animated: true)
    }
}
