//
//  PopUpViewController.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/30.
//

import Foundation
import SnapKit
import UIKit

final class PopoverContentController: UIViewController {

    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
//        stackView.spacing = 16.0
        stackView.distribution = .fillEqually
        stackView.alignment = .fill

        return stackView
    }()

//    private lazy var horizontalStackView: UIStackView = {
//        let stackView = UIStackView()
//        return stackView
//    }()

//    private lazy var icon: UIImageView = {
//        let imageView = UIImageView()
//        return imageView
//    }()

    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.setTitle("수정", for: .normal)
        button.titleLabel?.font = FontManager().largeFont()
        button.setTitleColor(UIColor.label, for: .normal)
        return button
    }()

    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("삭제", for: .normal)
        button.titleLabel?.font = FontManager().largeFont()
        button.setTitleColor(UIColor.systemRed, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true)
    }

    func setupView() {
        view.backgroundColor = .secondarySystemBackground

        view.addSubview(verticalStackView)

        [editButton, deleteButton].forEach {
            verticalStackView.addArrangedSubview($0)
        }

        verticalStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
