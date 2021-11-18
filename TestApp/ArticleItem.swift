//
//  ArticleItem.swift
//  TestApp
//
//  Created by Marin Saca on 16.11.2021.
//

import Foundation
import Mapper

public struct ArticleItem: Equatable {
    
    let title: String
    let description: String
    let content: String
    let url: String
    let image: String
    let publishedAt: String

}

// MARK: Parsing

extension ArticleItem: Mappable {
    
    struct Keys {
        
        static let title = "title"
        static let description = "description"
        static let content = "content"
        static let url = "url"
        static let image = "image"
        static let publishedAt = "publishedAt"
        
    }
    
    public init(map: Mapper) throws {
        
        try title = map.from(Keys.title)
        try description = map.from(Keys.description)
        try content = map.from(Keys.content)
        try url = map.from(Keys.url)
        image = map.optionalFrom(Keys.image) ?? ""
        try publishedAt = map.from(Keys.publishedAt)
        
    }
    
}
