//
//  PersonCreditResponseModel.swift
//  tmdb
//
//  Created by Kagan Girgin on 13.12.2020.
//

import Foundation

// MARK: - PersonCreditResponseModel
public struct PersonCreditResponseModel: Codable {
    public let cast, crew: [SearchResponseModelElement]?
    public let id: Int?

    public init(cast: [SearchResponseModelElement]?, crew: [SearchResponseModelElement]?, id: Int?) {
        self.cast = cast
        self.crew = crew
        self.id = id
    }
}
