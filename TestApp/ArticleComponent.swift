//
//  ArticleComponent.swift
//  TestApp
//
//  Created by Marin Saca on 16.11.2021.
//

import Foundation
import Mapper

public struct ArticleComponent: Equatable {
    
    let totalArticles: Int
    let articles: [ArticleItem]
    
}

// MARK: Parsing
extension ArticleComponent: Mappable {
    
    struct Keys {
        
        static let totalArticles = "totalArticles"
        static let articles = "articles"
        
    }
    
    public init(map: Mapper) throws {
        
        try totalArticles = map.from(Keys.totalArticles)
        articles = map.optionalFrom(Keys.articles,
                                    transformation: ArticleComponent.extractArticles) ?? []
        
    }
    
    private static func extractArticles(object: Any) throws -> [ArticleItem] {
        guard let list = object as? [NSDictionary] else {
            throw MapperError.convertibleError(value: object, type: [NSDictionary].self)
        }
        
        let holidays = list.compactMap({ ArticleItem.from($0) })
        
        return holidays
    }
}
