//
//  DatePickerAlertPresenter.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/20.
//  날짜 선택 Alert Presenter

import Foundation

protocol DatePickerAlertProtocol: AnyObject {
    func setupAppearance()
    func setupView()
    func dismiss()
}

final class DatePickerAlertPresenter: NSObject {
    private weak var viewController: DatePickerAlertProtocol?

    var date: Date

    init(
        viewController: DatePickerAlertProtocol?,
        date: Date
    ) {
        self.viewController = viewController
        self.date = date
    }

    func viewDidLoad() {
        viewController?.setupAppearance()
        viewController?.setupView()
    }

    func didTappedSelectButton() {
        viewController?.dismiss()
    }
}
