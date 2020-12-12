//
//  HomeRouter.swift
//  tmdb
//
//  Created by Kagan Girgin on 12.12.2020.
//

import UIKit

class HomeRouterInput: NSObject {
    func view(entryEntity: HomeEntryEntity) -> UINavigationController {
        let view = HomeViewController()
        let interactor = HomeInteractor()
        let entities = HomeEntities(entryEntity: entryEntity)
        let dependencies = HomePresenterDependencies(interactor: interactor, router: HomeRouterOutput(view))
        let presenter = HomePresenter(entities: entities, dependencies: dependencies, view: view)
        view.presenter = presenter
        interactor.entities = entities
        interactor.presenter = presenter
        
        let navController = UINavigationController(rootViewController: view)
        navController.navigationBar.tintColor = .black
        navController.navigationBar.topItem?.title = " "
        
        return navController
    }
}

class HomeRouterOutput: Routerable {
    private(set) weak var view: Viewable!

    init(_ view: Viewable) {
        self.view = view
    }
    
    func presentDetail(data: SearchResponseModelElement){
        DetailRouterInput().present(from: view, entryEntity: DetailEntryEntity(data: data))
    }
    
}
