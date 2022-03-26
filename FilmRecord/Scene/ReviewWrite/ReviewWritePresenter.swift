//
//  ReviewWritePresenter.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/26.
//  리뷰 작성 Presenter

import Foundation

protocol ReviewWriteProtocol: AnyObject {
    func setupNavigationBar()
    func setupView()
}

final class ReviewWritePresenter: NSObject {
    private weak var viewController: ReviewWriteProtocol?

    init(viewController: ReviewWriteProtocol) {
        self.viewController = viewController
    }

    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupView()
    }

    func didTappedRightBarButton() {
        // 리뷰 저장
    }
}
