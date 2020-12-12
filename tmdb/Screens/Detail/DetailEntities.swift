//
//  DetailEntities.swift
//  tmdb
//
//  Created by Kagan Girgin on 12.12.2020.
//

import Foundation

struct DetailEntryEntity {
    let data: SearchResponseModelElement
}

class DetailEntities {
    var entryEntity: DetailEntryEntity
    var tableViewSource: DetailTableViewSource?
    
    init(entryEntity: DetailEntryEntity) {
        self.entryEntity = entryEntity
    }
}
