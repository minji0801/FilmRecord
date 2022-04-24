//
//  Movie.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/25.
//  영화 정보 Model

import Foundation

struct Movie: Codable {
    let title: String               // 제목
    private let image: String       // 썸네일 이미지
    let pubDate: String             // 제작년도
    let director: String            // 감독
    let actor: String               // 출연 배우
    let userRating: String          // 유저 평점
    let link: String                // 영화 하이퍼텍스트 링크

    var imageURL: URL? { URL(string: image) }

    init(
        title: String,
        imageURL: String,
        pubDate: String,
        director: String,
        actor: String,
        userRating: String,
        link: String
    ) {
        self.title = title
        self.image = imageURL
        self.pubDate = pubDate
        self.director = director
        self.actor = actor
        self.userRating = userRating
        self.link = link
    }
}

extension Movie {
    static let EMPTY = Movie(title: "", imageURL: "", pubDate: "", director: "", actor: "", userRating: "", link: "")

    static let TEST = Movie(title: "test", imageURL: "", pubDate: "", director: "", actor: "", userRating: "", link: "")
}
