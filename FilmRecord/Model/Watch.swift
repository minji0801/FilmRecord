//
//  Watch.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/02.
//  보고 싶은 영화 model

struct Watch: Codable {
    let movie: Movie        // 영화 정보
    var watched: Bool       // 시청 여부

    init(
        movie: Movie,
        watched: Bool
    ) {
        self.movie = movie
        self.watched = watched
    }
}

extension Watch {
    static let EMPTY = Watch(movie: Movie.EMPTY, watched: false)

    static let TEST = Watch(movie: Movie.TEST, watched: false)
}
