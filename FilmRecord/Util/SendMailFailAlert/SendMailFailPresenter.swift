//
//  SendMailFailPresenter.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/16.
//  메일 보내기 실패 Alert Presenter

import Foundation

protocol SendMailFailProtocol: AnyObject {
    func setupAppearance()
    func setupView()

    func applyFont()
    func dismiss()
    func goToAppStore()
}

final class SendMailFailPresenter: NSObject {
    private weak var viewController: SendMailFailProtocol?

    init(viewController: SendMailFailProtocol?) {
        self.viewController = viewController
    }

    func viewDidLoad() {
        viewController?.setupAppearance()
        viewController?.setupView()
        viewController?.applyFont()
    }

    func didTappedDismissButton() {
        viewController?.dismiss()
    }

    func didTappedMoveButton() {
        viewController?.goToAppStore()
    }
}
