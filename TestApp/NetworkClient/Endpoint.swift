//
//  Endpoint.swift
//  TestApp
//
//  Created by Marin Saca on 16.11.2021.
//

import Foundation
import Alamofire

enum Endpoint {

    case search
    case getTopHeadlines

    // MARK: - Public Properties
    var method: Alamofire.HTTPMethod {
        return .post
    }
    
    var url: URL {
        let baseUrl = URL.getBaseUrl()

        switch self {
       
        case .search:
            return baseUrl.appendingPathComponent("search")
  
        case .getTopHeadlines:
            return baseUrl.appendingPathComponent("top-headlines")
        }
    }
}

extension URL {
    
    static func getBaseUrl() -> URL {
        guard let url = URL(string: Config.baseUrl) else {
            fatalError("Base url is not valid.")
        }

        return url
    }

}
