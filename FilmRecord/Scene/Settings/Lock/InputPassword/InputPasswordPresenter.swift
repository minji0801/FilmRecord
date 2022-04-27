//
//  InputPasswordPresenter.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/28.
//  비밀번화 입력 Presenter

import Foundation

protocol InputPasswordProtocol: AnyObject {
    func setupAppearance()
    func setupView()
    func applyFont()
}

final class InputPasswordPresenter: NSObject {
    private weak var viewController: InputPasswordProtocol?

    init(viewController: InputPasswordProtocol?) {
        self.viewController = viewController
    }

    func viewDidLoad() {
        viewController?.setupAppearance()
        viewController?.setupView()
        viewController?.applyFont()
    }
}
