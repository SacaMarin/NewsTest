//
//  NewsVM.swift
//  TestApp
//
//  Created by Marin Saca on 17.11.2021.
//

import Foundation
import UIKit

class NewsVM {
    
    private var articles: [ArticleItem]
    private var totalArticles: Int
    private var selectedArticle: ArticleItem?

    init() {
        articles = []
        totalArticles = 0
    }
    
    func getTopHeadlinesArticles(with VC: UIViewController, completion: @escaping(_ error: Error?) -> Void) {
        NetworkClient.default.getTopHeadlines { articlesMap, totalArticles, error in
            self.articles = articlesMap
            self.totalArticles = totalArticles
            
            completion(error)
        }
    }
    
    func getArticlesCount() -> Int {
        return articles.count
    }
    
    func getArticlesForRow(for row: Int) -> ArticleItem {
        return articles[row]
    }
    
    func selectArticleForRow(for row: Int) {
        selectedArticle = articles[row]
    }
    
    func getSelectedArticle() -> ArticleItem? {
        return selectedArticle
    }
    
    func setSelectedArticle(with article: ArticleItem?) {
        selectedArticle = article
    }
}
