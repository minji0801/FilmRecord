//
//  SearchMovieRequestModel.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/25.
//  영화 검색 요청 Model

import Foundation

struct MovieSearchRequestModel: Codable {
    let query: String
}
