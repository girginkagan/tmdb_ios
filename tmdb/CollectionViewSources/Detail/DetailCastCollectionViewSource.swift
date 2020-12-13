//
//  DetailCastCollectionViewSource.swift
//  tmdb
//
//  Created by Kagan Girgin on 13.12.2020.
//

import UIKit

final class DetailCastCollectionViewSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    let presenter: DetailPresenter
    let entities: DetailEntities
    
    init(presenter: DetailPresenter, entities: DetailEntities){
        self.presenter = presenter
        self.entities = entities
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return entities.resultCast?.cast?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCastCollectionViewCell", for: indexPath) as! DetailCastCollectionViewCell
        cell.updateCell(data: entities.resultCast?.cast?[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 115, height: 178)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if var item = entities.resultCast?.cast?[indexPath.row]{
            item.mediaType = MediaType.person
            presenter.goDetail(data: item)
        }
    }
}
