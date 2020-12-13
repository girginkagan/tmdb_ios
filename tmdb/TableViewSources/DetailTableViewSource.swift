//
//  DetailTableViewSource.swift
//  tmdb
//
//  Created by Kagan Girgin on 13.12.2020.
//

import UIKit

final class DetailTableViewSource: NSObject, UITableViewDataSource, UITableViewDelegate{
    
    let presenter: DetailPresenter
    let entities: DetailEntities
    
    init(presenter: DetailPresenter, entities: DetailEntities){
        self.presenter = presenter
        self.entities = entities
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if entities.entryEntity.data.mediaType == MediaType.person{
            if indexPath.row == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "DetailHeaderTableViewCell", for: indexPath) as! DetailHeaderTableViewCell
                cell.selectionStyle = .none
                cell.updateCell(data: entities.entryEntity.data)
                
                return cell
            }
            else if indexPath.row == 1{
                let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell", for: indexPath) as! TitleTableViewCell
                cell.selectionStyle = .none
                cell.updateCell(title: "Biography")
                
                return cell
            }
            else if indexPath.row == 2{
                let cell = tableView.dequeueReusableCell(withIdentifier: "DetailDescriptionTableViewCell", for: indexPath) as! DetailDescriptionTableViewCell
                cell.selectionStyle = .none
                cell.updateCell(desc: entities.resultPersonDetail?.biography ?? "There's no summary for this.")
                
                return cell
            }
            else if indexPath.row == 3{
                let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell", for: indexPath) as! TitleTableViewCell
                cell.selectionStyle = .none
                cell.updateCell(title: "Movies")
                
                return cell
            }
            else if indexPath.row == 4{
                let cell = tableView.dequeueReusableCell(withIdentifier: "DetailPersonMoviesTableViewCell", for: indexPath) as! DetailPersonMoviesTableViewCell
                cell.selectionStyle = .none
                cell.updateCell(presenter: presenter, entities: entities)
                
                return cell
            }
            else if indexPath.row == 5{
                let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell", for: indexPath) as! TitleTableViewCell
                cell.selectionStyle = .none
                cell.updateCell(title: "TVs")
                
                return cell
            }
            else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "DetailPersonTVsTableViewCell", for: indexPath) as! DetailPersonTVsTableViewCell
                cell.selectionStyle = .none
                cell.updateCell(presenter: presenter, entities: entities)
                
                return cell
            }
        }
        else{
            if indexPath.row == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "DetailHeaderTableViewCell", for: indexPath) as! DetailHeaderTableViewCell
                cell.selectionStyle = .none
                cell.updateCell(data: entities.entryEntity.data)
                
                return cell
            }
            else if indexPath.row == 1{
                let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell", for: indexPath) as! TitleTableViewCell
                cell.selectionStyle = .none
                cell.updateCell(title: "Summary")
                
                return cell
            }
            else if indexPath.row == 2{
                let cell = tableView.dequeueReusableCell(withIdentifier: "DetailDescriptionTableViewCell", for: indexPath) as! DetailDescriptionTableViewCell
                cell.selectionStyle = .none
                cell.updateCell(desc: entities.entryEntity.data.overview ?? "There's no summary for this.")
                
                return cell
            }
            else if indexPath.row == 3{
                let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell", for: indexPath) as! TitleTableViewCell
                cell.selectionStyle = .none
                cell.updateCell(title: "Videos")
                
                return cell
            }
            else if indexPath.row == 4{
                let cell = tableView.dequeueReusableCell(withIdentifier: "DetailVideosTableViewCell", for: indexPath) as! DetailVideosTableViewCell
                cell.selectionStyle = .none
                cell.updateCell(presenter: presenter, entities: entities)
                
                return cell
            }
            else if indexPath.row == 5{
                let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell", for: indexPath) as! TitleTableViewCell
                cell.selectionStyle = .none
                cell.updateCell(title: "Cast")
                
                return cell
            }
            else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCastTableViewCell", for: indexPath) as! DetailCastTableViewCell
                cell.selectionStyle = .none
                cell.updateCell(presenter: presenter, entities: entities)
                
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if entities.entryEntity.data.mediaType == MediaType.person{
            if indexPath.row == 1 || indexPath.row == 2{
                if entities.resultPersonDetail?.biography ?? "" == ""{
                    return 0
                }
            }
            else if indexPath.row == 3 || indexPath.row == 4{
                if (entities.resultPersonMovieCredits?.cast?.count ?? 0) == 0{
                    return 0
                }
            }
            else if indexPath.row == 5 || indexPath.row == 6{
                if (entities.resultPersonTVCredits?.cast?.count ?? 0) == 0{
                    return 0
                }
            }
        }
        else{
            if indexPath.row == 1 || indexPath.row == 2{
                if entities.entryEntity.data.overview ?? "" == ""{
                    return 0
                }
            }
            else if indexPath.row == 3 || indexPath.row == 4{
                if (entities.resultVideos?.count ?? 0) == 0{
                    return 0
                }
            }
            else if indexPath.row == 5 || indexPath.row == 6{
                if (entities.resultCast?.cast?.count ?? 0) == 0{
                    return 0
                }
            }
        }
        return UITableView.automaticDimension
    }
}
