//
//  ReviewWritePresenter.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/27.
//  리뷰 작성 Presenter

import Foundation
import UIKit

protocol ReviewWriteProtocol: AnyObject {
    func setupNavigationBar()
    func setupView()
    func showDatePicker()
    func keyboardDown()
}

final class ReviewWritePresenter: NSObject {
    private weak var viewController: ReviewWriteProtocol?

    private var date: Date = Date()

    init(viewController: ReviewWriteProtocol) {
        self.viewController = viewController
    }

    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupView()
    }

    func touchesBegan() {
        viewController?.keyboardDown()
    }

    func didTappedLeftBarButton() {
        // pop
    }

    func didTappedRightBarButton() {
        // 리뷰 저장
    }

    func didTappedDateLabel() {
        viewController?.showDatePicker()
    }
}

// MARK: UITextViewDelegate
extension ReviewWritePresenter: UITextViewDelegate {
    /// 텍스트 뷰 편집 시작
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor != UIColor.label {
            textView.text = nil
            textView.textColor = UIColor.label
        }
    }

    /// 텍스트 뷰 편집 종료
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "리뷰를 작성해주세요."
            textView.textColor = .systemGray3
        }
    }
}
