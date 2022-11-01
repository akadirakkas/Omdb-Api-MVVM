//
//  OmdbRequest.swift
//  Omdb-Api
//
//  Created by kadir on 31.10.2022.
//
import Foundation
import Alamofire

struct OmdbRequest {
    static let shared = OmdbRequest()

    struct Constants {
        static let topHeadlineUrl = "https://omdbapi.com/?apikey=b4343aa1&s="
        static let detailURL = "https://omdbapi.com/?apikey=b4343aa1&i="
    }
    
    private init() {}
    
    func getSearch(with query:String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        let urlString = Constants.topHeadlineUrl + query
        guard let url = URL(string: urlString.replacingOccurrences(of: " ", with: "%20")) else { return }
        
        AF.request(url).responseDecodable(of: MovieResult.self, queue: .main,  decoder: JSONDecoder()) { response in
            switch response.result {
            case .success(let dataModel):
                completion(.success(dataModel.movies ?? []))
            case .failure(let error) :
                completion(.failure(error))
            }
        }
    }
    
    func movieDetail(with imdbID: String,completion: @escaping (Result<MovieDetail, Error>) -> Void) {
        let urlString = Constants.detailURL + imdbID
        guard let url = URL(string: urlString.replacingOccurrences(of: " ", with: "%20")) else { return }
        
        AF.request(url).responseDecodable(of: MovieDetail.self, queue: .main,  decoder: JSONDecoder()) { response in
            switch response.result {
            case .success(let dataModel):
                completion(.success(dataModel.self ))
               
            case .failure(let error) :
                completion(.failure(error))
            }
        }
    }
    
}
