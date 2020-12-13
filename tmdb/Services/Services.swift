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
    
    //MARK: getCast
    public func getCast(id: String, type: MediaType, successCompletion: @escaping ((_ json : CastResponseModel) -> Void), errorCompletion: @escaping ((_ message : BaseModelError) -> Void)){
        var url = ""
        if type == MediaType.movie{
            url = (baseUrl + "movie/" + id + "/credits?api_key=e5cd138a4e58ac39dd26816e2b21fdea")
        }
        else if type == MediaType.tv{
            url = (baseUrl + "tv/" + id + "/credits?api_key=e5cd138a4e58ac39dd26816e2b21fdea")
        }
        
        Alamofire.request(url, method: .get, parameters: nil).responseObject { (response : DataResponse<CastResponseModel>) in
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
    
    //MARK: getVideos
    public func getVideos(id: String, type: MediaType, successCompletion: @escaping ((_ json : BaseModel<VideoResponseModel>) -> Void), errorCompletion: @escaping ((_ message : BaseModelError) -> Void)){
        var url = ""
        if type == MediaType.movie{
            url = (baseUrl + "movie/" + id + "/videos?api_key=e5cd138a4e58ac39dd26816e2b21fdea")
        }
        else if type == MediaType.tv{
            url = (baseUrl + "tv/" + id + "/videos?api_key=e5cd138a4e58ac39dd26816e2b21fdea")
        }
        
        Alamofire.request(url, method: .get, parameters: nil).responseObject { (response : DataResponse<BaseModel<VideoResponseModel>>) in
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
    
    //MARK: getPersonCredit
    public func getPersonCredit(id: String, type: MediaType, successCompletion: @escaping ((_ json : PersonCreditResponseModel) -> Void), errorCompletion: @escaping ((_ message : BaseModelError) -> Void)){
        var url = ""
        if type == MediaType.movie{
            url = (baseUrl + "person/" + id + "/movie_credits?api_key=e5cd138a4e58ac39dd26816e2b21fdea")
        }
        else if type == MediaType.tv{
            url = (baseUrl + "person/" + id + "/tv_credits?api_key=e5cd138a4e58ac39dd26816e2b21fdea")
        }
        
        Alamofire.request(url, method: .get, parameters: nil).responseObject { (response : DataResponse<PersonCreditResponseModel>) in
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
    
    //MARK: getPersonDetail
    public func getPersonDetail(id: String, successCompletion: @escaping ((_ json : PersonDetailResponseModel) -> Void), errorCompletion: @escaping ((_ message : BaseModelError) -> Void)){
        Alamofire.request(baseUrl + "person/" + id + "?api_key=e5cd138a4e58ac39dd26816e2b21fdea", method: .get, parameters: nil).responseObject { (response : DataResponse<PersonDetailResponseModel>) in
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
