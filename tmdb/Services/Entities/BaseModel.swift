//
//  BaseModel.swift
//  tmdb
//
//  Created by Kagan Girgin on 12.12.2020.
//

import Foundation

public struct BaseModel<T : Codable>: Codable {
    public let error: String?
    public let results: T?
    
    public init(error: String?, results: T?) {
        self.error = error
        self.results = results
    }
}
