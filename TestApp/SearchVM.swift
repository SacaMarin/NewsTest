//
//  SearchVM.swift
//  TestApp
//
//  Created by Marin Saca on 17.11.2021.
//

import Foundation
import UIKit
import CoreData

class SearchVM {
    
    private var titleSearch: Bool
    private var descrSearch: Bool
    private var contentSearch: Bool
    private var articles: [ArticleItem]
    private var articlesCount: Int
    private var searchWord: String
    private var selectedArticle: ArticleItem?
    private var selectDateFrom: String
    private var selectDateTo: String

    init() {
        titleSearch = Config.titleSearch
        descrSearch = Config.descrSearch
        contentSearch = Config.contentSearch
        articles = []
        articlesCount = 0
        searchWord = ""
        selectDateFrom = ""
        selectDateTo = ""
    }
 
    func searchArticlesBy(for vc: UIViewController,
                          with fromDate: String, with toDate: String,
                        completion: @escaping(_ error: Error?) -> Void) {
        NetworkClient.default.searchNews(for: searchWord, with: fromDate, with: toDate, with: getTitleForSearch(), with: Config.sortBy) { articlesMap, totalArticles, error in
            self.articles = articlesMap
            self.articlesCount = totalArticles
            
            completion(error)
        }
    }
    
    //MARK: - Getter
    func getSelectDateFrom() -> String {
        return selectDateFrom
    }
    
    func getSelectDateTo() -> String {
        return selectDateTo
    }
    
    func getTitleSearch() -> Bool {
        return titleSearch
    }
    
    func getDescSearch() -> Bool {
        return descrSearch
    }
    
    func getContentSearch() -> Bool {
        return contentSearch
    }
    
    func getSelectedArticle() -> ArticleItem? {
        return selectedArticle
    }
    
    //MARK: - Setter
    func setSelectDateFrom(with value: String) {
        selectDateFrom = value
    }
    
    func setSelectDateTo(with value: String) {
        selectDateTo = value
    }
    
    func setTitleSearch(with value: Bool) {
        titleSearch = value
    }
    
    func setDescrSearch(with value: Bool) {
        descrSearch = value
    }
    
    func setContentSearch(with value: Bool) {
        contentSearch = value
    }
    
    func setSearchWord(with value: String) {
        searchWord = value
    }
    
    func setSelectedArticle(with article: ArticleItem?) {
        selectedArticle = article
    }
    
    //MARK: - Get Title for Button
    func getTitleForSearch() -> String {
        var resultString: String = ""
        
        if Config.titleSearch && Config.descrSearch && Config.contentSearch  {
            return "All"
        }
        
        if Config.titleSearch {
            resultString = resultString.isEmpty ? "Title" : "\(resultString), Title"
        }
        
        if Config.descrSearch {
            resultString = resultString.isEmpty ? "Description" : "\(resultString), Description"
        }
        
        if Config.contentSearch {
            resultString = resultString.isEmpty ? "Content" : "\(resultString), Content"
        }
        
        return resultString
    }
    
    //MARK: - GET SELECT Articles
    func getCountArticles() -> Int {
        return articles.count
    }
    
    func getResultCountArticles() -> Int {
        return articlesCount
    }
    
    func getArticleForRow(for row: Int) -> ArticleItem {
        return articles[row]
    }
    
    func selectArticleForRow(for row: Int) {
        selectedArticle = articles[row]
    }
}
