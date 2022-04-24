//
//  MockMovieSearchManager.swift
//  FilmRecordTests
//
//  Created by 김민지 on 2022/04/24.
//  MovieSearchManager Mock

import XCTest
@testable import FilmRecord

final class MockMovieSearchManager: MovieSearchManagerProtocol {
    var keyword: String = ""
    var start: Int = 0
    var display: Int = 0

    var isCalledRequest = false

    func request(from keyword: String, start: Int, display: Int, completionHandler: @escaping ([Movie]) -> Void) {
        isCalledRequest = true
        self.keyword = keyword
        self.start = start
        self.display = display
    }
}
