//
//  EnterRatingPresenter.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/26.
//  영화 평점 입력 Presenter

import Foundation

protocol EnterRatingProtocol: AnyObject {
    func setupNavigationBar()
    func setupView()
}

final class EnterRatingPresenter: NSObject {
    private weak var viewController: EnterRatingProtocol?

    init(viewController: EnterRatingProtocol) {
        self.viewController = viewController
    }

    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupView()
    }

    func didTappedRightBarButton() {
        // 리뷰 작성 화면으로 이동하기
        // 평점도 같이 넘겨주기
    }
}
