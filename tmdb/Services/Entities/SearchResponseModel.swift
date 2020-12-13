//
//  SearchResponseModel.swift
//  tmdb
//
//  Created by Kagan Girgin on 12.12.2020.
//

import Foundation

// MARK: - MostPopularMoviesResponseModelElement
public struct SearchResponseModelElement: Codable {
    public let backdropPath: String?
    public let firstAirDate: String?
    public let genreIDS: [Int]?
    public let id: Int?
    public var mediaType: MediaType?
    public let name: String?
    public let originCountry: [String]?
    public let originalLanguage: String?
    public let originalName, overview: String?
    public let popularity: Double?
    public let posterPath: String?
    public let voteAverage: Double?
    public let voteCount: Int?
    public let adult: Bool?
    public let originalTitle, releaseDate, title: String?
    public let video: Bool?
    public let gender: Int?
    public let knownFor: [KnownFor]?
    public let knownForDepartment: String?
    public let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case genreIDS = "genre_ids"
        case id
        case mediaType = "media_type"
        case name
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case adult
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case title, video, gender
        case knownFor = "known_for"
        case knownForDepartment = "known_for_department"
        case profilePath = "profile_path"
    }

    public init(backdropPath: String?, firstAirDate: String?, genreIDS: [Int]?, id: Int?, mediaType: MediaType?, name: String?, originCountry: [String]?, originalLanguage: String?, originalName: String?, overview: String?, popularity: Double?, posterPath: String?, voteAverage: Double?, voteCount: Int?, adult: Bool?, originalTitle: String?, releaseDate: String?, title: String?, video: Bool?, gender: Int?, knownFor: [KnownFor]?, knownForDepartment: String?, profilePath: String?) {
        self.backdropPath = backdropPath
        self.firstAirDate = firstAirDate
        self.genreIDS = genreIDS
        self.id = id
        self.mediaType = mediaType
        self.name = name
        self.originCountry = originCountry
        self.originalLanguage = originalLanguage
        self.originalName = originalName
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.adult = adult
        self.originalTitle = originalTitle
        self.releaseDate = releaseDate
        self.title = title
        self.video = video
        self.gender = gender
        self.knownFor = knownFor
        self.knownForDepartment = knownForDepartment
        self.profilePath = profilePath
    }
}

// MARK: - KnownFor
public struct KnownFor: Codable {
    public let adult: Bool?
    public let genreIDS: [Int]?
    public let id: Int?
    public let mediaType: MediaType?
    public let originalLanguage: String?
    public let originalTitle, overview, posterPath, releaseDate: String?
    public let title: String?
    public let video: Bool?
    public let voteAverage: Double?
    public let voteCount: Int?
    public let firstAirDate, name: String?
    public let originCountry: [String]?
    public let originalName: String?

    enum CodingKeys: String, CodingKey {
        case adult
        case genreIDS = "genre_ids"
        case id
        case mediaType = "media_type"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case firstAirDate = "first_air_date"
        case name
        case originCountry = "origin_country"
        case originalName = "original_name"
    }

    public init(adult: Bool?, genreIDS: [Int]?, id: Int?, mediaType: MediaType?, originalLanguage: String?, originalTitle: String?, overview: String?, posterPath: String?, releaseDate: String?, title: String?, video: Bool?, voteAverage: Double?, voteCount: Int?, firstAirDate: String?, name: String?, originCountry: [String]?, originalName: String?) {
        self.adult = adult
        self.genreIDS = genreIDS
        self.id = id
        self.mediaType = mediaType
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.firstAirDate = firstAirDate
        self.name = name
        self.originCountry = originCountry
        self.originalName = originalName
    }
}

public enum MediaType: String, Codable {
    case movie = "movie"
    case person = "person"
    case tv = "tv"
}

public typealias SearchResponseModel = [SearchResponseModelElement]
