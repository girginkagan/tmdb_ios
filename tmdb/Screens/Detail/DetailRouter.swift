//
//  DetailRouter.swift
//  tmdb
//
//  Created by Kagan Girgin on 12.12.2020.
//

import UIKit

class DetailRouterInput: NSObject {
    private func view(entryEntity: DetailEntryEntity) -> DetailViewController {
        let view = DetailViewController()
        let interactor = DetailInteractor()
        let entities = DetailEntities(entryEntity: entryEntity)
        let dependencies = DetailPresenterDependencies(interactor: interactor, router: DetailRouterOutput(view))
        let presenter = DetailPresenter(entities: entities, dependencies: dependencies, view: view)
        view.presenter = presenter
        interactor.entities = entities
        interactor.presenter = presenter
        
        return view
    }
    
    func present(from: Viewable, entryEntity: DetailEntryEntity) {
        from.push(view(entryEntity: entryEntity), animated: true)
    }
}

class DetailRouterOutput: Routerable {
    private(set) weak var view: Viewable!

    init(_ view: Viewable) {
        self.view = view
    }
    
}
