//
//  Presenterable.swift
//  tmdb
//
//  Created by Kagan Girgin on 12.12.2020.
//

import UIKit

protocol Presenterable {
    associatedtype I: Interactorable
    associatedtype R: Routerable
    var dependencies: (interactor: I, router: R) { get }
}
