//
//  Toast.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/18.
//

import Toast

struct Toast {
    func toastStyle() -> ToastStyle {
        var style = ToastStyle()
        style.messageColor = .systemBackground
        style.messageFont = FontManager.largeFont()
        style.backgroundColor = .label

        return style
    }
}
