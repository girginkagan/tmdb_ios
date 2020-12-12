//
//  HomeInteractor.swift
//  tmdb
//
//  Created by Kagan Girgin on 12.12.2020.
//

import Foundation

protocol HomeInteractorOutputs: AnyObject{
    func onSuccess()
    func onSearchSuccess()
    func onNextPage()
    func onNextPageSearch()
    func onError(err: BaseModelError)
}

final class HomeInteractor: BaseInteractor, Interactorable{
    weak var presenter: HomeInteractorOutputs?
    weak var entities: HomeEntities?
    
    func getData(refresh: Bool){
        services.getMostPopularMovies(page: String(entities?.page ?? 1)) { [weak self] (success) in
            if let results = success.results{
                if self?.entities?.resultMostPopulars == nil || refresh{
                    self?.entities?.resultMostPopulars = results
                    self?.presenter?.onSuccess()
                }
                else{
                    if results.count == 0{
                        self?.entities?.noMorePageForMostPopular = true
                    }
                    self?.entities?.resultMostPopulars?.append(contentsOf: results)
                    self?.presenter?.onNextPage()
                }
            }
            else{
                self?.presenter?.onError(err: BaseModelError(errorCode: nil, message: nil, errors: nil))
            }
        } errorCompletion: { [weak self] (error) in
            self?.presenter?.onError(err: error)
        }

    }
    
    func getSearchData(q: String){
        entities?.lastSearchedQuery = q
        services.getSearchData(q: q, page: String(entities?.pageSearch ?? 1)) { [weak self] (success) in
            if let results = success.results{
                if self?.entities?.resultSearchMovies == nil{
                    self?.entities?.resultSearchMovies = results.filter{$0.mediaType == MediaType.movie}
                    self?.entities?.resultSearchTVs = results.filter{$0.mediaType == MediaType.tv}
                    self?.entities?.resultSearchPeople = results.filter{$0.mediaType == MediaType.person}
                    self?.presenter?.onSearchSuccess()
                }
                else{
                    let resultMovies = results.filter{$0.mediaType == MediaType.movie}
                    let resultTVs = results.filter{$0.mediaType == MediaType.tv}
                    let resultPeople = results.filter{$0.mediaType == MediaType.person}
                    
                    if resultMovies.count == 0{
                        self?.entities?.noMorePageForSearchMovies = true
                    }
                    
                    if resultTVs.count == 0{
                        self?.entities?.noMorePageForSearchTVs = true
                    }
                    
                    if resultPeople.count == 0{
                        self?.entities?.noMorePageForSearchPeople = true
                    }
                    
                    self?.entities?.resultSearchMovies?.append(contentsOf: resultMovies)
                    self?.entities?.resultSearchTVs?.append(contentsOf: resultTVs)
                    self?.entities?.resultSearchPeople?.append(contentsOf: resultPeople)
                    self?.presenter?.onNextPageSearch()
                }
            }
            else{
                self?.presenter?.onError(err: BaseModelError(errorCode: nil, message: nil, errors: nil))
            }
        } errorCompletion: { [weak self] (error) in
            self?.presenter?.onError(err: error)
        }

    }
}
