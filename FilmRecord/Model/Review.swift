//
//  Review.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/28.
//  리뷰 model

import Foundation

struct Review: Codable {
    let id: Int             // 아이디
    let date: String        // 기록일
    let movie: Movie        // 영화 정보
    let place: String       // 영화 본 장소
    let with: String        // 같이 본 사람
    let review: String      // 영화 리뷰 내용
    let rating: Double      // 영화 평점(사용자가 지정한)
    var favorite: Bool      // 좋아하는 영화인지

    init(
        id: Int,
        date: String,
        movie: Movie,
        place: String,
        with: String,
        review: String,
        rating: Double,
        favorite: Bool
    ) {
        self.id = id
        self.date = date
        self.movie = movie
        self.place = place
        self.with = with
        self.review = review
        self.rating = rating
        self.favorite = favorite
    }
}
