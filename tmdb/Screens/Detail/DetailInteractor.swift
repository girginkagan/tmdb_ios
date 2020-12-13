//
//  DetailInteractor.swift
//  tmdb
//
//  Created by Kagan Girgin on 12.12.2020.
//

import Foundation

protocol DetailInteractorOutputs: AnyObject{
    func onError(err: BaseModelError)
    func onDataReady()
}

final class DetailInteractor: BaseInteractor, Interactorable{
    weak var presenter: DetailInteractorOutputs?
    weak var entities: DetailEntities?
    
    func getData(){
        if (entities?.entryEntity.data.mediaType ?? MediaType.movie) == MediaType.movie || (entities?.entryEntity.data.mediaType ?? MediaType.movie) == MediaType.tv{
            services.getVideos(id: String(entities?.entryEntity.data.id ?? 0), type: entities?.entryEntity.data.mediaType ?? MediaType.movie) { [weak self] (success) in
                if let res = success.results{
                    self?.entities?.resultVideos = res
                    self?.getCast()
                }
                else{
                    self?.presenter?.onError(err: BaseModelError(errorCode: nil, message: nil, errors: nil))
                }
            } errorCompletion: { [weak self] (error) in
                self?.presenter?.onError(err: error)
            }
        }
        else{
            services.getPersonCredit(id: String(entities?.entryEntity.data.id ?? 0), type: MediaType.movie) { [weak self] (success) in
                self?.entities?.resultPersonMovieCredits = success
                self?.getPersonCreditTV()
            } errorCompletion: { [weak self] (error) in
                self?.presenter?.onError(err: error)
            }
        }
    }
    
    func getCast(){
        services.getCast(id: String(entities?.entryEntity.data.id ?? 0), type: entities?.entryEntity.data.mediaType ?? MediaType.movie) { [weak self] (success) in
            self?.entities?.resultCast = success
            self?.presenter?.onDataReady()
        } errorCompletion: { [weak self] (error) in
            self?.presenter?.onError(err: error)
        }
    }
    
    func getPersonCreditTV(){
        services.getPersonCredit(id: String(entities?.entryEntity.data.id ?? 0), type: MediaType.tv) { [weak self] (success) in
            self?.entities?.resultPersonTVCredits = success
            self?.getPersonDetail()
        } errorCompletion: { [weak self] (error) in
            self?.presenter?.onError(err: error)
        }
    }
    
    func getPersonDetail(){
        services.getPersonDetail(id: String(entities?.entryEntity.data.id ?? 0)) { [weak self] (success) in
            self?.entities?.resultPersonDetail = success
            self?.presenter?.onDataReady()
        } errorCompletion: { [weak self] (error) in
            self?.presenter?.onError(err: error)
        }
    }
}
