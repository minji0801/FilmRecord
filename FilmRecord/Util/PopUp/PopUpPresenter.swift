//
//  PopUpPresenter.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/31.
//  팝업(수정, 삭제) Presenter

import Foundation

protocol PopUpProtocol: AnyObject {
    func setupAppearance()
    func setupView()

    func applyFont()
    func postEditNotification()
    func postDeleteNotification()
}

final class PopUpPresenter: NSObject {
    private weak var viewController: PopUpProtocol?

    private var review: Review

    init(
        viewController: PopUpProtocol?,
        review: Review
    ) {
        self.viewController = viewController
        self.review = review
    }

    func viewDidLoad() {
        viewController?.setupAppearance()
        viewController?.setupView()
        viewController?.applyFont()
    }

    func didTappedEditButton() {
        viewController?.postEditNotification()
    }

    func didTappedDeleteButton() {
        viewController?.postDeleteNotification()
    }
}
