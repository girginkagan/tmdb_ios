//
//  CastResponseModel.swift
//  tmdb
//
//  Created by Kagan Girgin on 13.12.2020.
//

import Foundation

// MARK: - CastResponseModel
public struct CastResponseModel: Codable {
    public let id: Int?
    public let cast, crew: [SearchResponseModelElement]?

    public init(id: Int?, cast: [SearchResponseModelElement]?, crew: [SearchResponseModelElement]?) {
        self.id = id
        self.cast = cast
        self.crew = crew
    }
}
