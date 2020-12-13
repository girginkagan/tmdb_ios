//
//  DetailPresenter.swift
//  tmdb
//
//  Created by Kagan Girgin on 12.12.2020.
//

import UIKit
import SVProgressHUD

typealias DetailPresenterDependencies = (
    interactor: DetailInteractor,
    router: DetailRouterOutput
)

final class DetailPresenter: Presenterable {
    internal var entities: DetailEntities
    private weak var view: DetailViewInputs?
    let dependencies: DetailPresenterDependencies

    init(entities: DetailEntities,
         dependencies: DetailPresenterDependencies, view: DetailViewInputs)
    {
        self.entities = entities
        self.dependencies = dependencies
        self.view = view
    }
}

extension DetailPresenter: DetailViewOutputs {
    func viewDidLoad() {
        setUI()
    }
    
    func setUI(){
        view?.prepareUI()
        
        SVProgressHUD.show()
        dependencies.interactor.getData()
    }
    
    func setTableView(){
        entities.tableViewSource = DetailTableViewSource(presenter: self, entities: entities)
        view?.onTableViewReady(source: entities.tableViewSource)
        SVProgressHUD.dismiss()
    }
    
    func goDetail(data: SearchResponseModelElement){
        dependencies.router.presentDetail(data: data)
    }
}

extension DetailPresenter: DetailInteractorOutputs{
    func onError(err: BaseModelError) {
        SVProgressHUD.dismiss()
        view?.onError(err: err)
    }
    
    func onDataReady() {
        setTableView()
    }
    
}
