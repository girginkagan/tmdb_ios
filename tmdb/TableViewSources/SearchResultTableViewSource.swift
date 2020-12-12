//
//  SearchResultTableViewSource.swift
//  tmdb
//
//  Created by Kagan Girgin on 12.12.2020.
//

import UIKit

final class SearchResultTableViewSource: NSObject, UITableViewDataSource, UITableViewDelegate{
    
    let presenter: HomePresenter
    let entities: HomeEntities
    
    init(presenter: HomePresenter, entities: HomeEntities){
        self.presenter = presenter
        self.entities = entities
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch entities.selectedSearchSegment {
        case .movie:
            return entities.resultSearchMovies?.count ?? 0
        case .person:
            return entities.resultSearchPeople?.count ?? 0
        case .tv:
            return entities.resultSearchTVs?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        switch entities.selectedSearchSegment {
        case .movie:
            cell.updateCell(data: entities.resultSearchMovies?[indexPath.row])
        case .person:
            cell.updateCell(data: entities.resultSearchPeople?[indexPath.row])
        case .tv:
            cell.updateCell(data: entities.resultSearchTVs?[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 196
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        presenter.endEditing()
        if scrollView.contentOffset.y + scrollView.frame.size.height >= scrollView.contentSize.height - 100 && !entities.isLoadingSearch{
            if entities.selectedSearchSegment == .movie && !entities.noMorePageForSearchMovies || entities.selectedSearchSegment == .person && !entities.noMorePageForSearchPeople || entities.selectedSearchSegment == .tv && !entities.noMorePageForSearchTVs{
                presenter.getSearchNextPage()
            }
        }
    }
}
