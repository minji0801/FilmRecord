//
//  DetailPresenter.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/29.
//  리뷰 상세 Presenter

import Foundation
import UIKit

protocol DetailProtocol: AnyObject {
    func setupAppearance()
    func setupNavigationBar()
    func setupNoti()
    func setupGesture()
    func setupView(review: Review)

    func applyFont()
    func popViewController()
    func pushToEnterRatingViewController(_ review: Review)
    func showPopUpViewController(_ popoverContentController: PopUpViewController)
    func showDeleteAlert()
    func updateRightBarLikeButton(review: Review)
    func showToast(_ show: Bool)
}

final class DetailPresenter: NSObject {
    private weak var viewController: DetailProtocol?
    private let userDefaultsManager: UserDefaultsManagerProtocol

    private var review: Review

    init(
        viewController: DetailProtocol?,
        userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager(),
        review: Review
    ) {
        self.viewController = viewController
        self.userDefaultsManager = userDefaultsManager
        self.review = review
    }

    func viewDidLoad() {
        viewController?.setupAppearance()
        viewController?.setupNavigationBar()
        viewController?.setupNoti()
        viewController?.setupGesture()
        viewController?.setupView(review: review)

        viewController?.applyFont()
        viewController?.updateRightBarLikeButton(review: review)
    }

    func didTappedLeftBarButton() {
        viewController?.popViewController()
    }

    func didTappedRightBarMenuButton(_ sender: UIBarButtonItem) {
        let popoverContentController = PopUpViewController(review: review)
        popoverContentController.modalPresentationStyle = .popover
        popoverContentController.preferredContentSize = CGSize(width: 80, height: 100)

        if let popoverPresentationController = popoverContentController.popoverPresentationController {
            popoverPresentationController.permittedArrowDirections = .right
            popoverPresentationController.barButtonItem = sender
            popoverPresentationController.delegate = self
            viewController?.showPopUpViewController(popoverContentController)
        }
    }

    func didTappedRightBarLikeButton() {
        review.favorite = !review.favorite
        userDefaultsManager.editReview(id: review.id, newValue: review)
        viewController?.updateRightBarLikeButton(review: review)
        viewController?.showToast(review.favorite)
    }

    func editNotification() {
        viewController?.pushToEnterRatingViewController(review)
    }

    func deleteNotification() {
        viewController?.showDeleteAlert()
    }

    func deleteReviewNotification() {
        let id = review.id
        userDefaultsManager.deleteReview(id: id)
        viewController?.popViewController()
    }
}

// MARK: - UIPopoverPresentationControllerDelegate
extension DetailPresenter: UIPopoverPresentationControllerDelegate {

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }

    func popoverPresentationControllerDidDismissPopover(
        _ popoverPresentationController: UIPopoverPresentationController
    ) {

    }

    func popoverPresentationControllerShouldDismissPopover(
        _ popoverPresentationController: UIPopoverPresentationController
    ) -> Bool {
        return true
    }
}
