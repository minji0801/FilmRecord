//
//  ReviewWritePresenter.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/27.
//  리뷰 작성 Presenter

import Foundation
import UIKit

protocol ReviewWriteProtocol: AnyObject {
    func setupAppearance()
    func setupNavigationBar()
    func setupNoti()
    func setupView(review: Review, isEditing: Bool)

    func showDatePickerAlertViewController()
    func keyboardDown()
    func popViewController()
    func popToRootViewController()
}

final class ReviewWritePresenter: NSObject {
    private weak var viewController: ReviewWriteProtocol?
    private let userDefaultsManager: UserDefaultsManagerProtocol

    private var movie: Movie
    private var rating: Double

    var review: Review
    var isEditing: Bool

    init(
        viewController: ReviewWriteProtocol,
        userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager(),
        movie: Movie,
        rating: Double,
        review: Review,
        isEditing: Bool
    ) {
        self.viewController = viewController
        self.userDefaultsManager = userDefaultsManager
        self.movie = movie
        self.rating = rating
        self.review = review
        self.isEditing = isEditing
    }

    func viewDidLoad() {
        viewController?.setupAppearance()
        viewController?.setupNavigationBar()
        viewController?.setupNoti()
        viewController?.setupView(review: review, isEditing: isEditing)
    }

    func touchesBegan() {
        viewController?.keyboardDown()
    }

    func didTappedLeftBarButton() {
        viewController?.popViewController()
    }

    func didTappedRightBarButton(
        date: String,
        place: String?,
        with: String?,
        content: String?
    ) {
        guard let place = place,
              let with = with,
              var content = content else { return }

        if content == "리뷰를 작성해주세요." { content = "" }

        var id: Int
        if isEditing {
            id = review.id
        } else {
            id = userDefaultsManager.getReviewId()
        }

        let movieReview = Review(
            id: id,
            date: date,
            movie: movie,
            place: place,
            with: with,
            review: content,
            rating: rating,
            favorite: false
        )
        // isEditing 값 가져와서 편집 중이면 현재 review id에 덮어쓰고, 아니라면 새로 저장하기

        if isEditing {
            userDefaultsManager.editReview(id: id, newValue: movieReview)
        } else {
            userDefaultsManager.setReview(movieReview)
            userDefaultsManager.setReviewId()
        }
        viewController?.popToRootViewController()
    }

    func didTappedDateLabel() {
        viewController?.showDatePickerAlertViewController()
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
