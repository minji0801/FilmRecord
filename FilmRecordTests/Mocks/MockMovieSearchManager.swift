//
//  MockMovieSearchManager.swift
//  FilmRecordTests
//
//  Created by 김민지 on 2022/04/24.
//  MovieSearchManager Mock

import XCTest
@testable import FilmRecord

final class MockMovieSearchManager: MovieSearchManagerProtocol {
    var error: Error?
    var isCalledRequest = false

    func request(from keyword: String, start: Int, display: Int, completionHandler: @escaping ([Movie]) -> Void) {
        isCalledRequest = true
        if error == nil {
            completionHandler([Movie.TEST])
        }
    }
}
