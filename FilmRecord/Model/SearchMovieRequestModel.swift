//
//  SearchMovieRequestModel.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/25.
//  영화 검색 요청 Model

import Foundation

struct MovieSearchRequestModel: Codable {
    /// 시작 Index, 1 ~ 1000
    let start: Int
    /// 검색 결과 출력 건수, 10 ~ 100
    let display: Int
    /// 검색어
    let query: String
}
