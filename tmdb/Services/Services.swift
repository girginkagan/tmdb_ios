//
//  Services.swift
//  tmdb
//
//  Created by Kagan Girgin on 12.12.2020.
//

import Alamofire
import AlamofireMapper

class Services{
    let baseUrl = "https://api.themoviedb.org/3/"
    
    //MARK: getMostPopularMovies
    public func getMostPopularMovies(page: String, successCompletion: @escaping ((_ json : BaseModel<MostPopularMoviesResponseModel>) -> Void), errorCompletion: @escaping ((_ message : BaseModelError) -> Void)){
        Alamofire.request(baseUrl + "discover/movie?sort_by=popularity.desc&api_key=e5cd138a4e58ac39dd26816e2b21fdea&page=" + page, method: .get, parameters: nil).responseObject { (response : DataResponse<BaseModel<MostPopularMoviesResponseModel>>) in
            switch response.result {
            case .success(let json):
                if response.response!.statusCode == APIStatusCodes.Success.rawValue{
                    successCompletion(json)
                }
                else{
                    print(response.result)
                    errorCompletion(BaseModelError(errorCode: response.response!.statusCode, message: "An unknown error occured.", errors: nil))
                }
                break
            case .failure(let error):
                errorCompletion(BaseModelError(errorCode: nil, message: nil, errors: [ErrorData(field: APIErrors.Alamofire.rawValue, message: error.localizedDescription)]))
                break
            }
        }
    }
    
    //MARK: getSearchData
    public func getSearchData(q: String, page: String, successCompletion: @escaping ((_ json : BaseModel<SearchResponseModel>) -> Void), errorCompletion: @escaping ((_ message : BaseModelError) -> Void)){
        Alamofire.request((baseUrl + "search/multi?api_key=e5cd138a4e58ac39dd26816e2b21fdea&query=" + q + "&page=" + page).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "", method: .get, parameters: nil).responseObject { (response : DataResponse<BaseModel<SearchResponseModel>>) in
            switch response.result {
            case .success(let json):
                if response.response!.statusCode == APIStatusCodes.Success.rawValue{
                    successCompletion(json)
                }
                else{
                    print(response.result)
                    errorCompletion(BaseModelError(errorCode: response.response!.statusCode, message: "An unknown error occured.", errors: nil))
                }
                break
            case .failure(let error):
                errorCompletion(BaseModelError(errorCode: nil, message: nil, errors: [ErrorData(field: APIErrors.Alamofire.rawValue, message: error.localizedDescription)]))
                break
            }
        }
    }
}
