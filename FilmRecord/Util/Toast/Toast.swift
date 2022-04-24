//
//  Toast.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/18.
//

import Toast

struct Toast {
    func toastStyle(_ font: Font) -> ToastStyle {
        var style = ToastStyle()
        style.messageFont = font.largeFont
        style.messageColor = .systemBackground
        style.backgroundColor = .label

        return style
    }
}
