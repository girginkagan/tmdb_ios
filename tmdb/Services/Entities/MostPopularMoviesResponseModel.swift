//
//  MostPopularMoviesResponseModel.swift
//  tmdb
//
//  Created by Kagan Girgin on 12.12.2020.
//

import Foundation

// MARK: - MostPopularMoviesResponseModelElement
public struct MostPopularMoviesResponseModelElement: Codable {
    public let adult: Bool?
    public let backdropPath: String?
    public let genreIDS: [Int]?
    public let id: Int?
    public let originalLanguage, originalTitle, overview: String?
    public let popularity: Double?
    public let posterPath, releaseDate, title: String?
    public let video: Bool?
    public let voteAverage: Double?
    public let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    public init(adult: Bool?, backdropPath: String?, genreIDS: [Int]?, id: Int?, originalLanguage: String?, originalTitle: String?, overview: String?, popularity: Double?, posterPath: String?, releaseDate: String?, title: String?, video: Bool?, voteAverage: Double?, voteCount: Int?) {
        self.adult = adult
        self.backdropPath = backdropPath
        self.genreIDS = genreIDS
        self.id = id
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
}

public typealias MostPopularMoviesResponseModel = [MostPopularMoviesResponseModelElement]
