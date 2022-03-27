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
    func popViewController()
    func showAlertController()
}

final class ReviewWritePresenter: NSObject {
    private weak var viewController: ReviewWriteProtocol?

    private var movie: Movie
    private var rating: Double

    init(
        viewController: ReviewWriteProtocol,
        movie: Movie,
        rating: Double
    ) {
        self.viewController = viewController
        self.movie = movie
        self.rating = rating
    }

    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupView()
    }

    func touchesBegan() {
        viewController?.keyboardDown()
    }

    func didTappedLeftBarButton() {
        viewController?.popViewController()
    }

    func didTappedRightBarButton(date: String, place: String?, with: String?, review: String?) {
        guard let place = place,
              let with = with,
              let review = review else { return }

        if review == "리뷰를 작성해주세요." {
            viewController?.showAlertController()
        } else {
            // TODO: 리뷰 저장하기
        }
    }

    func didTappedDateLabel() {
        viewController?.showDatePicker()
    }
}

// MARK: - UITextFieldDelegate
extension ReviewWritePresenter: UITextFieldDelegate {
    /// Text Felid Return 클릭: 키보드 내리기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
