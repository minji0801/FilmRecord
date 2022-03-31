//
//  UserDefaultsManager.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/03/28.
//  UserDefaults 관련 manager

import Foundation

protocol UserDefaultsManagerProtocol {
    func getReviews() -> [Review]                  // 영화 리뷰 가져오기
    func setReview(_ newValue: Review)             // 영화 리뷰 저장하기
    func editReview(id: Int, newValue: Review)                      // 리뷰 수정하기
    func overwriteReview(_ value: [Review])        // 영화 리뷰 덮어쓰기

    func getReviewId() -> Int                           // 리뷰 아이디 가져오기
    func setReviewId()                                  // 리뷰 아이디 저장하기

    func getFavoriteMovies() -> [Review]           // 좋아하는 영화 가져오기
    func setFavoriteMovie(_ newValue: Review)      // 좋아하는 영화 저장하기
    func overwriteFavoriteMovie(_ value: [Review]) // 좋아하는 영화 덮어쓰기

//    func getMovieToWatch() -> [MovieToWatch]            // 보고 싶은 영화 가져오기
//    func setMovieToWatch(_ newValue: MovieToWatch)      // 보고 싶은 영화 저장하기
//    func overwriteToWatch(_ value: [MovieToWatch])      // 보고 싶은 영화 덮어쓰기
}

struct UserDefaultsManager: UserDefaultsManagerProtocol {
    /// UserDefaults Key
    enum Key: String {
        case review     // 영화 리뷰
        case reviewid   // 리뷰 아이디
        case favorite   // 좋아하는 영화
        case towatch    // 보고 싶은 영화
    }

    /// UserDefaults에서 영화 리뷰 가져오기
    func getReviews() -> [Review] {
        guard let data = UserDefaults.standard.data(forKey: Key.review.rawValue) else { return [] }
        return (try? PropertyListDecoder().decode([Review].self, from: data)) ?? []
    }

    /// UserDefaults에 영화 리뷰 저장하기
    func setReview(_ newValue: Review) {
        var currentReviews: [Review] = getReviews()
        currentReviews.insert(newValue, at: 0)
        UserDefaults.standard.setValue(try? PropertyListEncoder().encode(currentReviews), forKey: Key.review.rawValue)
    }

    /// 리뷰 수정하기
    func editReview(id: Int, newValue: Review) {
        var currentReviews: [Review] = getReviews()
        currentReviews[currentReviews.count - id - 1] = newValue
        UserDefaults.standard.setValue(try? PropertyListEncoder().encode(currentReviews), forKey: Key.review.rawValue)
    }

    /// UserDefaults에 영화 리뷰 덮어쓰기
    func overwriteReview(_ value: [Review]) {
        UserDefaults.standard.setValue(try? PropertyListEncoder().encode(value), forKey: Key.review.rawValue)
    }

    /// UserDefaults에서 리뷰 아이디 가져오기
    func getReviewId() -> Int {
        return UserDefaults.standard.integer(forKey: Key.reviewid.rawValue)
    }

    /// UserDefaults에 리뷰 아이디 저장하기
    func setReviewId() {
        let currentReviewId: Int = getReviewId()
        UserDefaults.standard.set(currentReviewId + 1, forKey: Key.reviewid.rawValue)
    }

    /// UserDefaults에서 좋아하는 영화 가져오기
    func getFavoriteMovies() -> [Review] {
        guard let data = UserDefaults.standard.data(forKey: Key.favorite.rawValue) else { return [] }
        return (try? PropertyListDecoder().decode([Review].self, from: data)) ?? []
    }

    /// UserDefaults에 좋아하는 영화 저장하기
    func setFavoriteMovie(_ newValue: Review) {
        var currentFavoriteMovies: [Review] = getFavoriteMovies()
        currentFavoriteMovies.insert(newValue, at: 0)
        UserDefaults.standard.setValue(
            try? PropertyListEncoder().encode(currentFavoriteMovies),
            forKey: Key.favorite.rawValue
        )
    }

    /// UserDefaults에 좋아하는 영화 덮어쓰기
    func overwriteFavoriteMovie(_ value: [Review]) {
        UserDefaults.standard.setValue(try? PropertyListEncoder().encode(value), forKey: Key.favorite.rawValue)
    }

    /// UserDefaults에서 보고 싶은 영화 가져오기
//    func getMovieToWatch() -> [MovieToWatch] {
//        guard let data = UserDefaults.standard.data(forKey: Key.towatch.rawValue) else { return [] }
//        return (try? PropertyListDecoder().decode([MovieToWatch].self, from: data)) ?? []
//    }

    /// UserDefaults에 보고 싶은 영화 저장하기
//    func setMovieToWatch(_ newValue: MovieToWatch) {
//        var currentToWatchs: [MovieToWatch] = getMovieToWatch()
//        currentToWatchs.insert(newValue, at: 0)
//        UserDefaults.standard.setValue(try? PropertyListEncoder().encode(currentToWatchs), forKey: Key.towatch.rawValue)
//    }

    /// UserDefaults에 보고 싶은 영화 덮어쓰기
//    func overwriteToWatch(_ value: [MovieToWatch]) {
//        UserDefaults.standard.setValue(try? PropertyListEncoder().encode(value), forKey: Key.towatch.rawValue)
//    }
}
