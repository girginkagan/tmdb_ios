//
//  DetailInteractor.swift
//  tmdb
//
//  Created by Kagan Girgin on 12.12.2020.
//

import Foundation

protocol DetailInteractorOutputs: AnyObject{
}

final class DetailInteractor: BaseInteractor, Interactorable{
    weak var presenter: DetailInteractorOutputs?
    weak var entities: DetailEntities?
}
