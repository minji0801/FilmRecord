//
//  InputPasswordViewController.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/28.
//  비밀번호 입력 화면

import Cosmos
import SnapKit
import UIKit

final class InputPasswordViewController: UIViewController {
    private var presenter: InputPasswordPresenter!

    init(isEntry: Bool) {
        super.init(nibName: nil, bundle: nil)
        presenter = InputPasswordPresenter(viewController: self, isEntry: isEntry)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 제목 라벨
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "암호 입력"
        label.textColor = .label

        return label
    }()

    /// 설명 라벨
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "암호를 입력해주세요."
        label.textColor = .secondaryLabel
        label.numberOfLines = 0

        return label
    }()

    private lazy var dotsView: CosmosView = {
        let cosmosView = CosmosView()
        cosmosView.rating = 0
        cosmosView.settings.totalStars = 4
        cosmosView.settings.starSize = 30
        cosmosView.settings.starMargin = 15

        cosmosView.settings.updateOnTouch = false
        cosmosView.settings.fillMode = .full

        cosmosView.settings.filledImage = UIImage(named: "heart.fill")
        cosmosView.settings.emptyImage = UIImage(named: "heart")

        return cosmosView
    }()

    /// 1 버튼
    private lazy var oneButton: UIButton = {
        let button = UIButton()
        button.tag = 1
        button.setTitle("1", for: .normal)
        button.addTarget(self, action: #selector(didTappedButton(_:)), for: .touchUpInside)

        return button
    }()

    /// 2 버튼
    private lazy var twoButton: UIButton = {
        let button = UIButton()
        button.tag = 2
        button.setTitle("2", for: .normal)
        button.addTarget(self, action: #selector(didTappedButton(_:)), for: .touchUpInside)

        return button
    }()

    /// 3 버튼
    private lazy var threeButton: UIButton = {
        let button = UIButton()
        button.tag = 3
        button.setTitle("3", for: .normal)
        button.addTarget(self, action: #selector(didTappedButton(_:)), for: .touchUpInside)

        return button
    }()

    /// 4 버튼
    private lazy var fourButton: UIButton = {
        let button = UIButton()
        button.tag = 4
        button.setTitle("4", for: .normal)
        button.addTarget(self, action: #selector(didTappedButton(_:)), for: .touchUpInside)

        return button
    }()

    /// 5 버튼
    private lazy var fiveButton: UIButton = {
        let button = UIButton()
        button.tag = 5
        button.setTitle("5", for: .normal)
        button.addTarget(self, action: #selector(didTappedButton(_:)), for: .touchUpInside)

        return button
    }()

    /// 6 버튼
    private lazy var sixButton: UIButton = {
        let button = UIButton()
        button.tag = 6
        button.setTitle("6", for: .normal)
        button.addTarget(self, action: #selector(didTappedButton(_:)), for: .touchUpInside)

        return button
    }()

    /// 7 버튼
    private lazy var sevenButton: UIButton = {
        let button = UIButton()
        button.tag = 7
        button.setTitle("7", for: .normal)
        button.addTarget(self, action: #selector(didTappedButton(_:)), for: .touchUpInside)

        return button
    }()

    /// 8 버튼
    private lazy var eightButton: UIButton = {
        let button = UIButton()
        button.tag = 8
        button.setTitle("8", for: .normal)
        button.addTarget(self, action: #selector(didTappedButton(_:)), for: .touchUpInside)

        return button
    }()

    /// 9 버튼
    private lazy var nineButton: UIButton = {
        let button = UIButton()
        button.tag = 9
        button.setTitle("9", for: .normal)
        button.addTarget(self, action: #selector(didTappedButton(_:)), for: .touchUpInside)

        return button
    }()

    /// 취소 버튼
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.tag = -1
        button.setTitle("취소", for: .normal)
        button.addTarget(self, action: #selector(didTappedButton(_:)), for: .touchUpInside)

        return button
    }()

    /// 0 버튼
    private lazy var zeroButton: UIButton = {
        let button = UIButton()
        button.tag = 0
        button.setTitle("0", for: .normal)
        button.addTarget(self, action: #selector(didTappedButton(_:)), for: .touchUpInside)

        return button
    }()

    /// Del 버튼
    private lazy var delButton: UIButton = {
        let button = UIButton()
        button.tag = -2
        button.setImage(UIImage(systemName: "delete.left"), for: .normal)
        button.addTarget(self, action: #selector(didTappedButton(_:)), for: .touchUpInside)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
}

extension InputPasswordViewController: InputPasswordProtocol {
    /// 화면 Appearance 설정
    func setupAppearance() {
        DarkModeManager.applyAppearance(mode: DarkModeManager.getAppearance(), viewController: self)
    }

    /// 뷰 구성
    func setupView(_ isEntry: Bool) {
        view.backgroundColor = .secondarySystemBackground

        // 앱에 진입할 때면 취소 버튼 없애기
        if isEntry {
            cancelButton.setTitle("", for: .normal)
            cancelButton.isEnabled = false
        }

        let topStackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel, dotsView])
        topStackView.axis = .vertical
        topStackView.alignment = .center
        topStackView.distribution = .fill
        topStackView.spacing = 20.0

        let row1 = ThreeButtonStackView(btn1: oneButton, btn2: twoButton, btn3: threeButton)
        let row2 = ThreeButtonStackView(btn1: fourButton, btn2: fiveButton, btn3: sixButton)
        let row3 = ThreeButtonStackView(btn1: sevenButton, btn2: eightButton, btn3: nineButton)
        let row4 = ThreeButtonStackView(btn1: cancelButton, btn2: zeroButton, btn3: delButton)

        let keypadStackView = UIStackView(arrangedSubviews: [row1, row2, row3, row4])
        keypadStackView.axis = .vertical

        [topStackView, keypadStackView].forEach {
            view.addSubview($0)
        }

        topStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(150.0)
        }

        keypadStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    /// 폰트 적용
    func applyFont() {
        let font = FontManager.getFont()

        titleLabel.font = font.twoExtraLargeFont
        descriptionLabel.font = font.mediumFont
    }

    /// 화면 닫기
    func dismiss() {
        NotificationCenter.default.post(name: NSNotification.Name("cancelInputPassword"), object: nil)
        dismiss(animated: false)
    }

    /// 암호 아이콘 업데이트
    func updateDotsView(_ dotsRating: Double) {
        dotsView.rating = dotsRating
    }

    /// 상단 스택뷰 UI 업데이트
    func updateTopStackView(_ tag: Int) {
        switch tag {
        case 0:
            descriptionLabel.text = "확인을 위해 한 번 더 입력해주세요."
        case 1:
            descriptionLabel.text = """
                                    암호가 일치하지 않습니다.
                                    처음부터 다시 시도해 주세요.
                                    """
        case 2:
            descriptionLabel.text = "암호가 일치하지 않습니다."
        default:
            break
        }
        dotsView.rating = 0.0
    }

    /// 홈화면 보여주기
    func showHomeViewController() {
        let homeViewController = HomeViewController()
        navigationController?.setViewControllers([homeViewController], animated: false)
    }
}

extension InputPasswordViewController {
    @objc func didTappedButton(_ sender: UIButton) {
        presenter.didTappedButton(sender.tag, dotsView.rating)
    }
}
