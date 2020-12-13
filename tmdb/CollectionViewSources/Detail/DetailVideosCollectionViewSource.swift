//
//  DetailVideosCollectionViewSource.swift
//  tmdb
//
//  Created by Kagan Girgin on 13.12.2020.
//

import UIKit

final class DetailVideosCollectionViewSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    let presenter: DetailPresenter
    let entities: DetailEntities
    
    init(presenter: DetailPresenter, entities: DetailEntities){
        self.presenter = presenter
        self.entities = entities
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return entities.resultVideos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailVideosCollectionViewCell", for: indexPath) as! DetailVideosCollectionViewCell
        cell.updateCell(data: entities.resultVideos?[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 138)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let youtubeId = entities.resultVideos?[indexPath.row].key ?? ""
        var youtubeUrl = URL(string:"youtube://\(youtubeId)")!
        if UIApplication.shared.canOpenURL(youtubeUrl){
            UIApplication.shared.open(youtubeUrl, options: [:], completionHandler: nil)
        }
        else{
            youtubeUrl = URL(string:"https://www.youtube.com/watch?v=\(youtubeId)")!
            UIApplication.shared.open(youtubeUrl, options: [:], completionHandler: nil)
        }
    }
}
