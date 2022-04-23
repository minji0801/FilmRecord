//
//  MockUserDefaultsManager.swift
//  FilmRecordTests
//
//  Created by 김민지 on 2022/04/23.
//  UserDefaultsManager Mock

import XCTest
@testable import FilmRecord

final class MockUserDefaultsManager: UserDefaultsManagerProtocol {
    var reviews: [Review] = []
    var newReview: Review!
    var watches: [Watch] = []
    var newWatch: Watch!
    var id: Int = 0

    var isCalledGetReviews = false
    var isCalledSetReview = false
    var isCalledEditReview = false
    var isCalledDeleteReview = false
    var isCalledOverwriteReview = false
    var isCalledGetReviewId = false
    var isCalledSetReviewId = false
    var isCalledGetFavoriteMovies = false
    var isCalledSetFavoriteMovie = false
    var isCalledOverwriteFavoriteMovie = false
    var isCalledGetMovieToWatch = false
    var isCalledSetMovieToWatch = false
    var isCalledOverwriteToWatch = false

    func getReviews() -> [Review] {
        isCalledGetReviews = true
        return reviews
    }

    func setReview(_ newValue: Review) {
        isCalledSetReview = true
        self.newReview = newValue
    }

    func editReview(id: Int, newValue: Review) {
        isCalledEditReview = true
        self.id = id
        self.newReview = newValue
    }

    func deleteReview(id: Int) {
        isCalledDeleteReview = true
        self.id = id
    }

    func overwriteReview(_ value: [Review]) {
        isCalledOverwriteReview = true
        self.reviews = value
    }

    func getReviewId() -> Int {
        isCalledGetReviewId = true
        return id
    }

    func setReviewId() {
        isCalledSetReviewId = true
    }

    func getFavoriteMovies() -> [Review] {
        isCalledGetFavoriteMovies = true
        return reviews
    }

    func setFavoriteMovie(_ newValue: Review) {
        isCalledSetFavoriteMovie = true
        self.newReview = newValue
    }

    func overwriteFavoriteMovie(_ value: [Review]) {
        isCalledOverwriteFavoriteMovie = true
        self.reviews = value
    }

    func getMovieToWatch() -> [Watch] {
        isCalledGetMovieToWatch = true
        return watches
    }

    func setMovieToWatch(_ newValue: Watch) {
        isCalledSetMovieToWatch = true
        self.newWatch = newValue
    }

    func overwriteToWatch(_ value: [Watch]) {
        isCalledOverwriteToWatch = true
        self.watches = value
    }
}
