//
//  Configuration.swift
//  TestApp
//
//  Created by Marin Saca on 16.11.2021.
//

import Foundation

struct Config {
    //API Config
    static let baseUrl = "https://gnews.io/api/v4"
    static let apiToken = "7143e63d06454c1fef24108ac27b81b9"
    static let sortByDate = "publishedAt"
    static let sortByRelevance = "relevance"

    static var titleSearch: Bool = true
    static var descrSearch: Bool = true
    static var contentSearch: Bool = true

    static var searchHystory: [String] = []
    static var sortBy: String = "publishedAt"
}
