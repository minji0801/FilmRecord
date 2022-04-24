//
//  DeleteAlertPresenter.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/31.
//  리뷰 삭제 Alert Presenter

import Foundation

protocol DeleteAlertProtocol: AnyObject {
    func setupAppearance()
    func setupView()

    func applyFont()
    func dismiss()
    func postDeleteNotification()
}

final class DeleteAlertPresenter: NSObject {
    private weak var viewController: DeleteAlertProtocol?

    init(viewController: DeleteAlertProtocol?) {
        self.viewController = viewController
    }

    func viewDidLoad() {
        viewController?.setupAppearance()
        viewController?.setupView()
        viewController?.applyFont()
    }

    func didTappedCancleButton() {
        viewController?.dismiss()
    }

    func didTappedDeleteButton() {
        viewController?.dismiss()
        viewController?.postDeleteNotification()
    }
}
