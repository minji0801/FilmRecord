//
//  String+.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/25.
//  html 태그 제거

import Foundation

extension String {
    var htmlEscaped: String {
        guard let encodedData = self.data(using: .utf8) else { return self }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        do {
            let attributed = try NSAttributedString(
                data: encodedData,
                options: options,
                documentAttributes: nil
            )
            return attributed.string
        } catch {
            return self
        }
    }

    var withComma: String {
        return self.split(separator: "|").joined(separator: ", ")
    }
}
