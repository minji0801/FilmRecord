//
//  SearchMovieResponseModel.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/25.
//  영화 검색 응답 모델

import Foundation

struct MovieSearchResponseModel: Decodable {
    var items: [Movie] = []
}
