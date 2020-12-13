//
//  VideoResponseModel.swift
//  tmdb
//
//  Created by Kagan Girgin on 13.12.2020.
//

import Foundation

// MARK: - VideoResponseModelElement
public struct VideoResponseModelElement: Codable {
    public let id, iso639_1, iso3166_1, key: String?
    public let name, site: String?
    public let size: Int?
    public let type: String?

    enum CodingKeys: String, CodingKey {
        case id
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case key, name, site, size, type
    }

    public init(id: String?, iso639_1: String?, iso3166_1: String?, key: String?, name: String?, site: String?, size: Int?, type: String?) {
        self.id = id
        self.iso639_1 = iso639_1
        self.iso3166_1 = iso3166_1
        self.key = key
        self.name = name
        self.site = site
        self.size = size
        self.type = type
    }
}

public typealias VideoResponseModel = [VideoResponseModelElement]
