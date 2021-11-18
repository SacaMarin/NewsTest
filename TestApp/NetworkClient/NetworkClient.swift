//
//  NetworkClient.swift
//  TestApp
//
//  Created by Marin Saca on 16.11.2021.
//

import Foundation
import Alamofire
import Mapper

final class NetworkClient {
    
    private struct Keys {
        static let data = "data"
        static let totalArticles = "totalArticles"
        static let articles = "articles"
        static let token = "token"
        static let byWord = "q"
        static let from = "from"
        static let to = "to"
        static let inAtributes = "in"
        static let sortBy = "sortBy"
    }
    
    static var `default`: NetworkClient {
        return NetworkClient()
    }
    
    func getTopHeadlines(completion: @escaping(_ articlesMap: [ArticleItem], _ totalArticles: Int, _ error: Error?) -> Void) {
        let parameters = [
            Keys.token: Config.apiToken
        ] as [String: Any]
        
        AF.request(Endpoint.getTopHeadlines.url, method: .get, parameters: parameters)
            .responseJSON { (response) in
                switch response.result {
                case .success(let data):
                    print(data)
                    
                    guard let dict = data as? NSDictionary,
                          let totalArticles = dict[Keys.totalArticles] as? Int,
                          let articles = dict[Keys.articles] as? [NSDictionary] else {
                              return completion([], 0, nil)
                          }
                    
                    let articlesMap = articles.compactMap({ ArticleItem.from($0) })
                    
                    completion(articlesMap, totalArticles, nil)
                case .failure(let error):
                    completion([], 0, error)
                }
            }
    }
    
    func searchNews(for word: String,with fromDate: String, with toDate: String,with inArticles: String,with sortby: String, completion: @escaping(_ articlesMap: [ArticleItem], _ totalArticles: Int, _ error: Error?) -> Void) {
        let parameters = [
            Keys.token: Config.apiToken,
            Keys.byWord: word,
            Keys.from: fromDate,
            Keys.to: toDate,
            Keys.inAtributes: inArticles,
            Keys.sortBy: sortby
        ] as [String: Any]
        
        AF.request(Endpoint.search.url, method: .get, parameters: parameters)
            .responseJSON { (response) in
                switch response.result {
                case .success(let data):
                    print(data)
                    
                    guard let dict = data as? NSDictionary,
                          let totalArticles = dict[Keys.totalArticles] as? Int,
                          let articles = dict[Keys.articles] as? [NSDictionary] else {
                              return completion([], 0, nil)
                          }
                    
                    let articlesMap = articles.compactMap({ ArticleItem.from($0) })
                    
                    completion(articlesMap, totalArticles, nil)
                case .failure(let error):
                    completion([], 0, error)
                }
            }
    }
}
