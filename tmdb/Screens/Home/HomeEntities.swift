//
//  HomeEntities.swift
//  tmdb
//
//  Created by Kagan Girgin on 12.12.2020.
//

import Foundation

struct HomeEntryEntity {
}

class HomeEntities {
    var entryEntity: HomeEntryEntity
    var page = 1
    var pageSearch = 1
    var resultMostPopulars: MostPopularMoviesResponseModel?
    var resultSearchMovies: SearchResponseModel?
    var resultSearchPeople: SearchResponseModel?
    var resultSearchTVs: SearchResponseModel?
    var tableViewSource: HomeTableViewSource?
    var tableViewSourceSearch: SearchResultTableViewSource?
    var isLoading = false
    var isLoadingSearch = false
    var noMorePageForMostPopular = false
    var noMorePageForSearchMovies = false
    var noMorePageForSearchPeople = false
    var noMorePageForSearchTVs = false
    var lastSearchedQuery = ""
    var selectedSearchSegment = MediaType.movie
    
    init(entryEntity: HomeEntryEntity) {
        self.entryEntity = entryEntity
    }
}
