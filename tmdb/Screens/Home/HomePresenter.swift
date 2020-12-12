//
//  HomePresenter.swift
//  tmdb
//
//  Created by Kagan Girgin on 12.12.2020.
//

import UIKit
import SVProgressHUD

typealias HomePresenterDependencies = (
    interactor: HomeInteractor,
    router: HomeRouterOutput
)

final class HomePresenter: Presenterable {
    internal var entities: HomeEntities
    private weak var view: HomeViewInputs?
    let dependencies: HomePresenterDependencies

    init(entities: HomeEntities,
         dependencies: HomePresenterDependencies, view: HomeViewInputs)
    {
        self.entities = entities
        self.dependencies = dependencies
        self.view = view
    }
}

extension HomePresenter: HomeViewOutputs {
    func refreshData() {
        entities.noMorePageForMostPopular = false
        entities.page = 1
        dependencies.interactor.getData(refresh: true)
    }
    
    func viewDidLoad() {
        setUI()
    }
    
    func setUI(){
        view?.prepareUI()
        
        SVProgressHUD.show()
        dependencies.interactor.getData(refresh: false)
    }
    
    func getNextPage(){
        entities.isLoading = true
        entities.page+=1
        dependencies.interactor.getData(refresh: false)
    }
    
    func getSearchNextPage(){
        entities.isLoadingSearch = true
        entities.pageSearch+=1
        dependencies.interactor.getSearchData(q: entities.lastSearchedQuery)
    }
    
    func endEditing(){
        view?.endEditing()
    }
}

extension HomePresenter: HomeInteractorOutputs{
    func onSearchSegmentChanged(segment: MediaType) {
        entities.selectedSearchSegment = segment
    }
    
    func onSearchSuccess() {
        entities.tableViewSourceSearch = SearchResultTableViewSource(presenter: self, entities: entities)
        view?.onTableViewReadySearch(source: entities.tableViewSourceSearch)
    }
    
    func getSearchData(q: String) {
        entities.resultSearchMovies = nil
        entities.resultSearchPeople = nil
        entities.resultSearchTVs = nil
        dependencies.interactor.getSearchData(q: q)
    }
    
    func onNextPageSearch() {
        entities.isLoadingSearch = false
        view?.reloadTableViewSearch()
    }
    
    func onNextPage() {
        entities.isLoading = false
        view?.reloadTableView()
    }
    
    func onSuccess() {
        entities.tableViewSource = HomeTableViewSource(presenter: self, entities: entities)
        view?.onTableViewReady(source: entities.tableViewSource)
        SVProgressHUD.dismiss()
    }
    
    func onError(err: BaseModelError) {
        SVProgressHUD.dismiss()
        view?.onError(err: err)
    }
}
