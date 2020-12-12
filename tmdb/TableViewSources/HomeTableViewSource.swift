//
//  HomeTableViewSource.swift
//  tmdb
//
//  Created by Kagan Girgin on 12.12.2020.
//

import UIKit

final class HomeTableViewSource: NSObject, UITableViewDataSource, UITableViewDelegate{
    
    let presenter: HomePresenter
    let entities: HomeEntities
    
    init(presenter: HomePresenter, entities: HomeEntities){
        self.presenter = presenter
        self.entities = entities
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        
        return entities.resultMostPopulars?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell", for: indexPath) as! TitleTableViewCell
            cell.updateCell(title: "Most Populars")
            
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
            cell.updateCell(data: entities.resultMostPopulars?[indexPath.row])
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 70
        }
        return 196
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        presenter.endEditing()
        if scrollView.contentOffset.y + scrollView.frame.size.height >= scrollView.contentSize.height - 100 && !entities.isLoading && !entities.noMorePageForMostPopular{
            presenter.getNextPage()
        }
    }
}
