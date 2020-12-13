//
//  PersonDetailResponseModel.swift
//  tmdb
//
//  Created by Kagan Girgin on 13.12.2020.
//

import Foundation

// MARK: - PersonDetailResponseModel
public struct PersonDetailResponseModel: Codable {
    public let adult: Bool?
    public let alsoKnownAs: [String]?
    public let biography, birthday: String?
    public let gender, id: Int?
    public let imdbID, knownForDepartment, name, placeOfBirth: String?
    public let popularity: Double?
    public let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case adult
        case alsoKnownAs = "also_known_as"
        case biography, birthday, gender, id
        case imdbID = "imdb_id"
        case knownForDepartment = "known_for_department"
        case name
        case placeOfBirth = "place_of_birth"
        case popularity
        case profilePath = "profile_path"
    }

    public init(adult: Bool?, alsoKnownAs: [String]?, biography: String?, birthday: String?, gender: Int?, id: Int?, imdbID: String?, knownForDepartment: String?, name: String?, placeOfBirth: String?, popularity: Double?, profilePath: String?) {
        self.adult = adult
        self.alsoKnownAs = alsoKnownAs
        self.biography = biography
        self.birthday = birthday
        self.gender = gender
        self.id = id
        self.imdbID = imdbID
        self.knownForDepartment = knownForDepartment
        self.name = name
        self.placeOfBirth = placeOfBirth
        self.popularity = popularity
        self.profilePath = profilePath
    }
}
